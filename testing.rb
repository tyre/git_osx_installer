require "open3"
puts "Let's do this!\n"
Open3.popen3("./testing.rb") do |test_input, test_output, test_error|
  puts test_output.gets.chomp
  test_input.puts STDIN.gets.chomp
  puts test_output.gets.chomp
end
puts "\nWe did that!"