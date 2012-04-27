require "open3"
GIT_HOSTED_URL = "http://ftp.de.debian.org/debian/pool/main/g/git/git_1.7.2.5.orig.tar.gz"

def capture(command)
  Open3.capture3(command)
end

def install_git
  puts "first we need to download git..."
  system("curl -O #{GIT_HOSTED_URL} ; sh")
end

def config_ssh
  if system('cd ~/.ssh')
    backup_and_rm_ssh
  end
  generate_ssh_keys
end

def backup_and_rm_ssh
  puts "You already have ssh keys at ~/.ssh"
  puts "We'll back them up to ~/.ssh/key_backup and generate new ones"
  system("mkdir key_backup && cp id_rsa* key_backup && rm id_rsa*")
end

def output_ssh_to_github
  puts "Alright. Now that that's finished, you need to upload the key to your github account."
  puts "Go to github.com, click on account settings in the upper right hand corner."
  puts "Next, select 'SSH Keys' on the left hand side and create a new one with 'Add SSH key'."
  puts "Name it whatever you want. When you next hit enter on the command line, you'll have the SSH key copied to your clipboard."
end
  
def add_key_to_github
  output_ssh_instructions
  gets
  system("cat ~/.ssh/id_rsa.pub | pbcopy")
  puts "Paste into github."
end

def generate_ssh_keys
  puts "What is the email address of your GitHub account?"
  $email = gets.chomp
  stdout, stderr, status = capture("ssh-keygen -t rsa -C \'#{$email}\'")
  if status == 0
    add_key_to_github
  end
end

stdout, stderr, status = capture("git --version")
unless stdout =~ /git version (.*)/
  puts "You don't seem to have git installed. Installing..."
  install_git
else
  stdout =~ /git version (.*)/
  version = $1
  puts "You already have git (version #{version})!"
  puts "Let's see if it is set up..."
end
config_ssh