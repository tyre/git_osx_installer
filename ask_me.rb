#!/usr/bin/ruby

require 'open3'

puts "Would you like to add some numbers?"
if gets =~ /^y/i
  Open3.popen3("ruby add_me.rb") do |stdin,stdout,stderr|
    puts stdout.gets.chomp
    stdout.puts STDIN.gets.chomp
    puts stdout.gets.chomp
  end
  puts "Was it good for you?"
else
  puts "Your loss"
end