require "open3"
# require "./add_me"

def capture(command)
  Open3.capture3(command)
end

system("ruby add_me.rb")