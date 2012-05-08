#!/usr/bin/env ruby

puts "In add_me Gimme some numbers:"
line = gets
puts line.split(/\s*/).map(&:to_i).reduce(0) { |acc,x| acc + x }