require 'nokogiri'

### Script Settings ###
quiet = true
dryrun = false
wordpress_import_file = "/wordpress/ryanclarkenet.wordpress.2014-07-22.xml"
temp_html_file = "temp.html"
output_dir = "content-new/"
#######################

def yaml_front_matter(item)
  <<-eos
---
title: "#{item.xpath(".//title").text}"
#{item.xpath(".//wp:post_type").text == "page" ? 'url:' : 'slug:'} "#{item.xpath(".//wp:post_name").text}"
wordpress_url: "#{item.xpath(".//link").text}"
date: "#{item.xpath(".//wp:post_date").text.split.first}"
tags: [#{item.xpath(".//category[@domain='post_tag']").map{ |x| '"' + x.text + '"' }.join(', ')}]
categories: [#{item.xpath(".//category[@domain='category']").map{ |x| '"' + x.text + '"' }.join(', ')}]
description: "#{item.xpath(".//excerpt:encoded").text.gsub(/\"/, '\"')}"

---

  eos
end

def wrap_content_in_html(item)
  builder = Nokogiri::HTML::Builder.new do |doc|
    doc.html {
      doc.body {
        doc.cdata(item.xpath(".//content:encoded").inner_text)
      }
    }
  end
  builder.to_html
end

wp = Nokogiri::XML(File.open(Dir.pwd + wordpress_import_file))
items = wp.xpath("//item").reverse

img_file = "/wordpress/img.txt"
File.delete(img_file) if File.exists?(img_file)

items.each do |item|
  item_type = item.xpath(".//wp:post_type").text
  item_content = item.xpath(".//content:encoded").inner_text.strip

  if ((item_type == "post" || item_type == "page") && item_content.length > 0) then 

    regex = /<img [^<>]+>/
    item_content.scan(regex).each { |x| File.open(Dir.pwd + img_file, 'a') { |f| f << x + "\n" } }


    out_file = yaml_front_matter(item)
  
    html_content = wrap_content_in_html(item)
    File.write(temp_html_file, html_content) unless dryrun
  
    puts item.xpath(".//wp:post_name").text unless quiet
    out_file << `pandoc -f html -t markdown_github --atx-headers #{temp_html_file}` unless dryrun
    #puts out_file unless quiet
    content_type_dir = "#{output_dir}#{item.xpath(".//wp:post_type").text}"
    Dir.mkdir(content_type_dir) unless Dir.exists?(content_type_dir)
    File.write("#{content_type_dir}/#{item.xpath(".//wp:post_date").text.split.first}-#{item.xpath(".//wp:post_name").text}.md", out_file) unless dryrun
    print "." if quiet
  end
end

File.delete(temp_html_file) if File.exists?(temp_html_file)
puts "\ndone"


