alias config='/usr/bin/git --git-dir $HOME/.linux/ --work-tree=$HOME' >> $HOME/.bashrc
. ~/.bashrc
echo ".linux" >> .gitignore
git clone --bare https://github.com/ditadi/.linux.git $HOME/.linux
function config {
  /usr/bin/git --git-dir=$HOME/.linux --work-tree=$HOME $@
}
mkdir -p .linux-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out .linux.";
else
  echo "Backing up pre-existing dot files.";
  config checkout 2>&1 | egrep "\s+\." | awk {'print$1'} | xargs -I{} mv {} .linux-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
