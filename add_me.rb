#!/usr/bin/env ruby

puts "Gimme some numbers:"
line = gets
puts line.split(/\s*/).map(&:to_i).reduce(0) { |acc,x| acc + x }