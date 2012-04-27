def configure_globals
  configure_name
  configure_email
end

def configure_name
  puts "Yo dawg, please enter your first and last name."
  username = gets.chomp
  system("git config --global user.name \'#{username}\'")
end

def configure_email
  system("git config --global user.email \'#{$email}\'")
end