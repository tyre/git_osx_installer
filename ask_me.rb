#!/usr/bin/ruby

require 'open3'

puts "Would you like to add some numbers?"
if gets =~ /^y/i
  r, w = IO.pipe
  pid = Process.spawn("ruby add_me.rb", out: w, :in => r)
  puts r.read.chomp
  puts "BOOM! Numbers!"
else
  puts "Your loss"
end