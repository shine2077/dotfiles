# Using GNU Stow to manage your dotfiles
I accidentally stumbled upon something yesterday that I felt like sharing, which fell squarely into the "why the hell didn’t I know about this before?" category. In this post, I’ll describe how to manage the various configuration files in your GNU/Linux home directory (aka "dotfiles" like .bashrc) using GNU Stow.

The difficulty is that it would be helpful to manage one’s configuration files with a version control system like Git, Mercurial or Bazaar, but many/most dotfiles reside at the top-level of your home directory, where it wouldn’t be a good idea to initialize a VCS repository. Over time I’ve come across various programs which aim to manage this for you by keeping all the files in a subdirectory and then installing or linking them into their appropriate places. None of those programs ever really appealed to me. They would require a ton of dependencies (like Ruby and a ton of libraries for it) or they would require me to remember how to use them, which is difficult when really for such a task you rarely use the program.

Lately I’ve been using GNU Stow to manage programs I install from source to /usr/local/. Basically, in this typical usage, you install locally built packages to /usr/local/stow/${PKGNAME}-{PKGVERSION} and then from /usr/local/stow/ you run # stow ${PKGNAME}-${PKGVERSION} and the program generates symbolic links to all the programs' files into the appropriate places under /usr/local/. Then, when you uninstall a program via Stow, you don’t have to worry about any stray files that you or a provide Makefile may have missed. It also makes handling alternate versions of a program quite easy (i.e. when I’m experimenting with different configurations of dwm or st).

Some time ago I happened across a mailing list posting where someone described using Stow to manage the installation of their dotfiles. I didn’t pay much attention to it but my brain must have filed it away for later. Yesterday I decided to give it a try and I have to say that it is so much more convenient than those other dedicated dotfile-management programs, even if it wasn’t an immediately obvious option.

The procedure is simple. I created the ${HOME}/dotfiles directory and then inside it I made subdirectories for all the programs whose cofigurations I wanted to manage. Inside each of those directories, I moved in all the appropriate files, maintaining the directory structure of my home directory. So, if a file normally resides at the top level of your home directory, it would go into the top level of the program’s subdirectory. If a file normally goes in the default ${XDG_CONFIG_HOME}/${PKGNAME} location (${HOME}/.config/${PKGNAME}), then it would instead go in ${HOME}/dotfiles/${PKGNAME}/.config/${PKGNAME} and so on. Finally, from the dotfiles directory, you just run $ stow $PKGNAME and Stow will symlink all the package’s configuration files to the appropriate locations. It’s then easy to make the dotfiles a VCS repository so you can keep track of changes you make (plus it makes it so much easier to share configurations between different computers, which was my main reason to do it).

You would then create a dotfiles subdirectory and move all the files there:
```shell

~/dotfiles/
├── nvim/
│   └── .config/nvim/
│       ├── init.lua          # 或 init.vim
│       ├── lua/              # 自定义模块（可选）
│       └── ...
├── kitty/
│   └── .config/kitty/
│       ├── kitty.conf
│       ├── themes/           # 自定义主题（可选）
│       └── ...
├── tmux/
│   └── .tmux.conf.local      # oh-my-tmux 用户只需这个！
├── zsh/
│   ├── .zshrc
│   ├── .zshenv               # （如有）
│   └── .zprofile             # （如有，macOS 常用）
```

Then, perform the following commands:
```shell


```
$ cd ~/dotfiles
$ stow zsh
$ stow kitty
$ stow nvim
$ stow tmux

```


```
And, voila, all your config files (well, symbolic links to them) are all in the correct place, however disorganized that might be, while the actual files are all neatly organized in your dotfiles directory, which is easily turned into a VCS repo. One handy thing is that if you use multiple computers, which may not have the same software installed on them, you can pick and choose which configurations to install when you need them. All of your dotfiles are always available in your dotfiles directory, but if you don’t need the configuration for one program, you simply don’t Stow it and thus it does not clutter your home directory.

## deploy on new machine

```shell
# 1. Clone your dotfiles repository
git clone https://github.com/yourname/dotfiles.git ~/dotfiles

# 2. Install oh-my-tmux (if you're using it)
git clone --depth=1 https://github.com/gpakosz/.tmux.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~/.tmux.conf

# 3. Deploy all configurations using Stow
cd ~/dotfiles
stow nvim kitty tmux zsh
```


Well, that’s all there is to it. Hopefully someone else out there finds this useful! I know I’ve found it to be a huge help.
