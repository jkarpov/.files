# Installation
Assumes
- Git is installed
- User has .bashrc

# New System
```shell
alias config='/usr/bin/git --git-dir=$HOME/.linux/ --work-tree=$HOME'
echo ".linux" >> .gitignore
git clone --bare https://github.com/ditadi/.linux $HOME/.linux
alias dotfile='/usr/bin/git --git-dir=$HOME/.linux/ --work-tree=$HOME'
config checkout
```

[Hacker News](http://news.ycombinator.com/item?id=11070797 "Hacker News")

[Atlassian Blog](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ "Blog")


