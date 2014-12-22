require 'date'

$post_dir = "hugo/content/draft/"

def new_post_template(timestamp, title)
  <<-eos
---
title: "#{title}"
slug: "#{sluggify(title)}"
date: #{timestamp.iso8601}
tags: ["SEP"]
categories: ["Technology"]
frameworks: []
description: ""
featured: ""
draft: true

---


  eos
end

def sluggify(title)
  title.downcase.gsub(/\W/, "-").gsub(/-+/, "-").gsub(/-$/, "")
end

def requires_args(count, message)
  for i in 0..count do
    if ARGV[i].nil?
      puts message     
      exit
    end
  end
end

class Args
  def initialize
    @args = []
    @messages = []
  end

  def define(name, type, default_value)
    name = default_value.nil? ? name.upcase : "[#{name.downcase}]"
    value = cast(ARGV.shift, type, name)
    value = value.nil? ? default_value : value
    @args << { value: value, name: name, type: type }
  end

  def cast(value, type, name)
    begin
      if value.nil?
        nil
      elsif type == String
        value
      elsif type == DateTime
        DateTime.parse(value)
      elsif type == File
        value if File.exist?(value)
      else
        nil
      end
    rescue ArgumentError => e
      @messages << e.message + " in '#{name}' argument: '#{value}'"
    end
  end

  def validate
    is_valid = @messages.count == 0
    @args.each do |arg|
      is_valid &= !arg[:value].nil?
    end
    is_valid
  end

  def puts_syntax(command = nil)
    command = command.nil? ? caller_locations(1,1)[0].label : command
    puts_syntax = "ruby #{File.path(__FILE__)} #{command}"
    @args.each { |arg| puts_syntax += " #{arg[:name]}" }
    puts @messages
    puts puts_syntax
  end

  def method_missing(method_id)
    @args.find { |arg| arg[:name].gsub(/\W/, "").downcase == method_id.to_s.downcase }[:value]
  end
end

def create_args
  args = Args.new
  args.define("title", String, nil)
  args.define("timestamp", DateTime, DateTime.now)
  args
end

def create
  args = create_args
  if !args.validate
    args.puts_syntax
    exit
  end

  post_file_name = "#{args.timestamp.to_date.iso8601}-#{sluggify(args.title)}.md"
  post_file_path = $post_dir + post_file_name

  unless File.exists?(post_file_path)
    Dir.mkdir($post_dir) unless Dir.exists?($post_dir)
    File.write(post_file_path, new_post_template(args.timestamp, args.title))
  end

  puts post_file_path
  exit
end

def retitle_args
  args = Args.new
  args.define("old_file_path", File, nil)
  args.define("new_title", String, nil)
  args
end

def retitle
  args = retitle_args
  if !args.validate
    args.puts_syntax
    exit
  end

  file_path = File.dirname(args.old_file_path)
  old_file_date = args.old_file_path.match(/\/(\d{4}-\d{2}-\d{2})-/)
  new_file_path = "#{file_path}#{old_file_date}#{sluggify(args.new_title)}.md"

  file = File.read(args.old_file_path)
  file.gsub!(/title: ".+"/, "title: \"#{args.new_title}\"")
  file.gsub!(/slug: ".+"/, "slug: \"#{sluggify(args.new_title)}\"")

  File.write(new_file_path, file)
  File.delete(args.old_file_path)

  puts new_file_path
  exit
end

commands = ["create", "retitle"]
command = ARGV.shift
if commands.include?(command)
  send(command)
else
  commands.each { |command| send(command + "_args").puts_syntax(command) }
end

