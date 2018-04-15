# setup
# source - http://news.ycombinator.com/item?id=11070797

git clone --bare git@github.com:tadyshev/.unix.git $HOME/.unix
alias dot='git --git-dir=$HOME/.unix/ --work-tree=$HOME'

dot checkout
dot config status.showUntrackedFiles no
