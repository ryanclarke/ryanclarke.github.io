require 'date'

def new_post_template(timestamp, title)
  <<-eos
---
title: "#{title}"
slug: "#{sluggify(title)}"
date: #{timestamp.iso8601}
tags: ["SEP"]
categories: ["Technology"]
description: ""
featured: ""
draft: true

---


  eos
end

def sluggify(title)
  title.downcase.gsub(/\W/, "-").gsub(/-+/, "-").gsub(/-$/, "")
end

post_dir = "hugo/content/draft/"
title = ARGV[0] || "New post"
timestamp = ARGV[1] || DateTime.now

post_file_name = "#{timestamp.to_date.iso8601}-#{sluggify(title)}.md"
post_file_path = post_dir + post_file_name

unless File.exists?(post_file_path)
  Dir.mkdir(post_dir) unless Dir.exists?(post_dir)
  File.write(post_file_path, new_post_template(timestamp, title))
end

puts post_file_path

