#Dot File Manager
This dot file manager is a tool to keep track of all or some of the dot files stored in a users home directory or sub directories. This is accomplished by putting all files that need to be tracked in a specific version controlled directory (~/dotfiles by default). Then symlinks are created in the users home directory to point to all of the files in the specified dot directory. For more information about this approach I suggest reading [Using Git to Manage Your Dotfiles](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/) which gives a basic overview of the approach used here.

This repository consists of two parts.

**Dot File Manager** - This is a bash script named **dotm** that automates many of the tasks that revolve around managing the dot files.

**My Configs** - This consists of custom aliases, shell prompts, path modifications, .bashrc, .vimrc, etc. Basically all the settings/commands/etc that I would want on a server/desktop that I work on.

##DOTM (Dot File Manager - Bash Script)

###Features
* **Handles symlinks for sub directories** in the dot files directory. This will match the directory structure in the users home directory. So ~/dotfiles/somedir/.somefile will have a link created in ~/somedir/.somefile.
* Creates **backups** of files that exist in the users home directory. Places backup in a user defined directory (~/dotfiles/backup by default) and appends a timestamp to the filename
* **Automatically creates symlink** for all files in the dot files directory (~/dotfiles by default) except for [special directories](#Special-Directories).
* **Custom directory** (default ~/dotfiles/custom) to put files that won't be symlinked.
* **Bin directory** (default ~/dotfiles/bin) to put scripts that won't be symlinked. Will be added to path via .bashrc.
* **Source directory** (default ~/dotfiles/source) to put source files that won't be symlinked. Will be sourced via .bashrc.
* Option to **ask before creating each symlink**.
* Option to create **symlinks from a minimal list**. Allowing for only some symlinks to be created on specific servers.
* Updates dot files from **remote repository** on each run.
* **Command line options** to change default settings (remote repository, dotfile directory, etc).

###Requirements
There are no requirements to run this script other than having a standard bash prompt. DOTM will setup the directory and structure for you when it is run. Also, it is **recommended to have git installed** as dotm will use that to pull config files from another repository (this repo by default).

###Installation
Dotm can be installed using my configs or as a bare structure for your own configs. If you choose to install with my configs you can still modify or add to them. It is your choice if you want to start with my customizations or a clean slate.

**DOTM with My Configs**

This command will download the dotm bash script and run it in bash.

```bash
bash <(wget -O - https://raw.github.com/brettbatie/dotfiles/master/bin/dotm)
```

Now anytime you want to pull changes and automatically create the symlinks just run the command **./dotm**

**DOTM with Bare Structure**

The last line in the below commands will set the repository to use when pulling/updating dot files. It is recommended to change this line to a valid repository. However, an invalid repository will still successfully create the dot file directory structure.

The below commands will create the ~/dotfiles/bin directory, download the dotm bash script and then run it.

```bash
mkdir -p ~/dotfiles/bin && wget -O ~/dotfiles/bin/dotm https://raw.github.com/brettbatie/dotfiles/master/bin/dotm && chmod +x ~/dotfiles/bin/dotm
~/dotfiles/bin/./dotm -r git://github.com/username/dotfiles/
```

Now anytime you want to pull changes and automatically create the symlinks just run the command **~/dotfiles/bin/./dotm** or just **dotm** if you add it to the path.

###Settings & Command line Arguments
Dotm has default settings that can be modified at the top of the bash script as well as command line arguments that can be used. dotm --help will output the following information

$ dotm --help

```bash
USAGE: dotm [-options] [-d /path/to/dotFileDirectory] [-r masterRepository]

    -d dotFileDirectory : The directory that contains the static files that will
                         be linked to from the ~ directory. If the 
                         dotFileDirectory is not specified then ~/dotfiles is
                         used by default.

    -r masterRepository : The url/path to the git repository that changes will 
                         be pushed and pulled from.

    -a : Will create symlinks for all files in the dot file directory without 
         asking questions. Special directories (bin, source, etc) will still be
         skipped.

    -m : Create symlinks using the minimal list

    -h : this help screen
```
Additionally, the following settings can be changed at the top of the dotm bash script

```bash
dotDir=$HOME/dotfiles
masterRepository=git://github.com/brettbatie/dotfiles

# comma delimited list for only creating a minimal set of symlinks
minimalSymlinkFiles=".vimrc,.gitconfig"

# special directories
backupDir=$dotDir/dotfiles-backup
customDir=$dotDir/custom
binDir=$dotDir/bin
sourceDir=$dotDir/source
```

###Special Directories

Dotm will create symlinks in the users home directory pointing to all files in the dot files directory (default ~/dotfiles) except for the following directories. These directories have special rules which are defined below.

* **.hg, .git, README.md** - are ignored.
* **backup** - Stores files that are overwritten when symlinks are created. When creating a symlink dotm will first check if there is a file that wil be overwritten in the users home directory. If a file will be overwritten it copies the files to the backup directory and then adds a timestamp to the filename.
* **custom** - This directory is not processed by dotm. It is a good directory to store custom files that should not have symlinks. For example, I store a list of apps that I like to have installed in this folder. ~~FIXME: Checkout the blah & blah functions in blah~~
* **bin** - Used to store scripts that will be added to the path. This is added to the path via my [.bashrc](https://github.com/brettbatie/dotfiles/blob/master/.bashrc) file.
* **source** - Used to store files that will be sourced. The source files are processed in alphabetical order via my [.bashrc](https://github.com/brettbatie/dotfiles/blob/master/.bashrc) file.

###Multiple dotFile Directories (private files)
...More to come

###Automate via cron
...More to come


Inspired by:

* https://github.com/cowboy/dotfiles
* http://vcs-home.branchable.com/
* http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
* https://github.com/mathiasbynens/dotfiles
* Many others who have kindly shared their custom commands/function/settings
