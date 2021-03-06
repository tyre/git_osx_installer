
GIT_HOSTED_URL = "http://ftp.de.debian.org/debian/pool/main/g/git/git_1.7.2.5.orig.tar.gz"
module GithubInit

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
    system("cd ~/.ssh && mkdir key_backup && cp id_rsa* key_backup/ && echo 'rm id_rsa*'")
  end

  def output_ssh_instructions
    puts "Alright. Now that that's finished, you need to upload the key to your github account."
    puts "Go to github.com, click on account settings in the upper right hand corner."
    puts "Next, select 'SSH Keys' on the left hand side and create a new one with 'Add SSH key'."
    puts "Name it whatever you want. When you next hit enter on the command line, you'll have the SSH key copied to your clipboard."
  end

  def add_key_to_github
    output_ssh_instructions
    gets
    system("cat ~/.ssh/id_rsa.pub | pbcopy")
    puts "Now paste into github!"
    puts "Next, let's setup your machine's configuration files so github knows more "
    puts "then just crazy string of characters (we're friends now.)"
    git_global_config
  end

  def git_global_config
    set_global_email
    set_global_name
  end

  def set_global_name
    name_instructions
  end

  def name_instructions
    puts "May I have your first and last name please?"
    puts "When you commit, this is the name that will show up."
  end

  def get_names
    puts "Firstname:"
    fname = gets.chomp
    puts "Lastname:"
    lname = gets.chomp
  end

  def set_global_email
    puts "Setting email: git config --global user.name '#{$email}'"
    system("git config --global user.name '#{$email}'")
  end

  def generate_ssh_keys
    puts "What is the email address of your GitHub account?"
    $email = gets.chomp
    if system("cd ~/derp; ssh-keygen -t rsa -C \'#{$email}\'") 
      add_key_to_github
    else
      puts "oops, we were unable to generate an ssh key. I don't know what to do now :("
      exit
    end
  end

end
include GithubInit
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
