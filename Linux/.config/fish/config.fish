# I don't want abbreviated paths
set fish_prompt_pwd_dir_length 0

# disable normal greeting, see below
set fish_greeting 

### ROS Stuff --------------------
source /opt/ros/melodic/share/rosbash/rosfish


### Utils ------

# git abbreviations
abbr gs 'git status'
abbr gc 'git commit -m'
abbr gp 'git push'

# other abbr
abbr cls 'printf "\033c"'
abbr ma '/mnt/c/Users/luisb/git/ma-thesis/'


### CLion Remote Environment ------
set -l sshd_status (service ssh status)
if string match -q "*not running*" $sshd_status
  sudo service ssh --full-restart
end



### Greeting ------
# with a chance of 2/6...
set -l prob 6
set -l dice_roll (math (random) % $prob)

# ... show a commit message 
if test $dice_roll -eq 0
    set -l todays_commit (curl --silent --fail -m 0.5 http://whatthecommit.com/index.txt)
    cowsay -f duck "Today's commit message:

    "\"$todays_commit\" | lolcat
    
# ... or show a fortune     
else if test $dice_roll -eq 1
    fortune -s -n 100 | cowsay -f duck | lolcat
end