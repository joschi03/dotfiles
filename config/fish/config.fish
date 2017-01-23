# dotfiles related stuff
set -gx PATH $PATH ~/.dotfiles/bin

# user's bin
set -gx PATH $PATH ~/bin

# no greeting
set fish_greeting ""

# git alias
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.cm commit
git config --global alias.st status
git config --global alias.ad add
git config --global alias.df diff
git config --global alias.dfc "diff --cached"
git config --global alias.br branch
git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit"
git config --global alias.lola "log --graph --decorate --pretty=oneline --abbrev-commit --all"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.subup "submodule update --init --recursive"
git config --global alias.subst "submodule status --recursive"
git config --global alias.root "rev-parse --show-toplevel"

# abbreviations
abbr -a g='git'
abbr -a gp='git push'
abbr -a gpa='git push --all'
abbr -a gu='git pull'
abbr -a gs='git status'
abbr -a gd='git diff'
abbr -a gdc='git diff --cached'
abbr -a gm='git commit -m'
abbr -a gma='git commit -am'
abbr -a gb='git branch'
abbr -a gba='git branch -a'
abbr -a gc='git checkout'
abbr -a gcb='git checkout -b'
abbr -a gr='git root'
abbr -a grv='git remote -v'
abbr -a gcd='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"'
abbr -a gl='git log'
abbr -a glg='git lg'
abbr -a glol='git lol'
abbr -a glola='git lola'
abbr -a gua="find . -maxdepth 3 -type d -name .git | xargs dirname |xargs -P 40 -n 1 -I '{}' sh -c 'cd {}; echo {}; git pull'"
abbr -a gsa="find . -maxdepth 3 -type d -name .git | xargs dirname |xargs -n 1 -I '{}' sh -c 'cd {}; echo {}; git status'"

# Add all files by default
function ga
  set arg $argv .
  git add "$argv"
end

# Current branch or SHA if detached.
alias gbs='git branch | perl -ne '"'"'/^\* (?:\(detached from (.*)\)|(.*))/ && print "$1$2"'"'"''

# vim related stuff
alias vi="vim"
alias vim="nvim -p"
set -x EDITOR vi
set -x VISUAL_EDITOR nvim -p -u ~/.vim/.vimrc

if test -e ~/.config/fish/config_local.fish
  . ~/.config/fish/config_local.fish
end

# set locales
if status -l; and test -r /etc/locale.conf
    while read -l kv
        echo set -gx (string split "=" -- $kv)
        set -gx (string split "=" -- $kv)
    end </etc/locale.conf
end

# X stuff
function XX
  rm -rf ~/.cache/sessions/xf*
  exec startx
end

if [ (tty) = "/dev/tty1" -a (whoami) = "joschi" ]
  XX
end
