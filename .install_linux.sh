alias config='/usr/bin/git --git-dir $HOME/.linux/ --work-tree=$HOME' >> $HOME/.bashrc
. ~/.bashrc
echo ".linux" >> .gitignore
git clone --bare https://github.com/ditadi/.linux.git $HOME/.linux
function config {
  /usr/bin/git --git-dir=$HOME/.linux --work-tree=$HOME $@
}
config checkout
config config status.showUntrackedFiles no
