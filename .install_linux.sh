# Must test this file
alias dotfiles='/usr/bin/git --git-dir $HOME/.linux/ --work-tree=$HOME' >> $HOME/.zshrc
. ~/.zshrc
echo ".linux" >> .gitignore
git clone --bare https://github.com/ditadi/.linux.git $HOME/.linux
function dotfiles {
  /usr/bin/git --git-dir=$HOME/.linux --work-tree=$HOME $@
}
dotfiles checkout -f
dotfiles config status.showUntrackedFiles no
