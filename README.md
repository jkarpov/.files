## Dotfiles managed by git

```shell
alias dot='/usr/bin/git --git-dir=$HOME/.linux/ --work-tree=$HOME'
dot config status.showUntrackedFiles no
echo ".linux" >> .gitignore
git clone --bare https://github.com/ditadi/.linux $HOME/.linux
alias dot='/usr/bin/git --git-dir=$HOME/.linux/ --work-tree=$HOME'
dot checkout
```

## References
[1] [Hacker News](http://news.ycombinator.com/item?id=11070797 "Hacker News")

