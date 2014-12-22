def sluggify(title)
  title.downcase.gsub(/\W/, "-").gsub(/-+/, "-").gsub(/-$/, "")
end

post_dir = "hugo/content/draft/"
old_file_name = ARGV[0]
title = ARGV[1]
new_file_name = "#{old_file_name[0..28]}-#{sluggify(title)}.md"

file = File.read(old_file_name)
file.gsub!(/title: ".+"/, "title: \"#{title}\"")
file.gsub!(/slug: ".+"/, "slug: \"#{sluggify(title)}\"")

File.write(new_file_name, file)
File.delete(old_file_name)

puts new_file_name

