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