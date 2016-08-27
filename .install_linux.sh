alias config='/usr/bin/git --git-dir $HOME/.linux/ --work-tree=$HOME' >> $HOME/.bashrc
. ~/.bashrc
echo ".linux" >> .gitignore
git clone --bare https://github.com/ditadi/.linux.git $HOME/.linux
function config {
  /usr/bin/git --git-dir=$HOME/.linux --work-tree=$HOME $@
}
config checkout
if [ $? = 0 ]; then
  echo "Checked out .linux.";
else
  echo "Removing pre-existing dot files.";
  config checkout 2>&1 | egrep "\s+\." | awk {'print$1'} \
  xargs -I{} rm {} 
fi;
config checkout
config config status.showUntrackedFiles no
