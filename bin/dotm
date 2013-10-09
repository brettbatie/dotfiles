#!/bin/bash
#####
# Creates symlinks in the home directory pointing to all files in the given 
# dotfiles directory. It will symlink files in sub directories as well.
#
# It does not create symlinks for files in the following special directories:
# .hg, .git, bin, $backupDir, source, apps.list
#
# Bin directory: added to the path via the bashrc file
# source directory: all files in source directory are executed via a command in bashrc
# Backup Directory: before creating the symlinks to the dot files. We check if the file already exists in the ~ 
# directory or sub directory. If it does exist then the file is copied to the backup directory with a timestamp 
# appended to the filename. The files in the backup directory maintain the directory structure.
# minimal list
# apps.list: Stores a line delimited list of application which the user might want to install
# 
# more than one repo. I am currently using a dotfiles and dotfiles_private. With the command line arguments I can use 
# dotm for both cases. I setup my default paths for my dotfiles in dotm. Then for my private files I setup and alias
# for dotmp which passes the private dot file directory and different repository.
#
# Inspired by:
# https://github.com/cowboy/dotfiles
# http://vcs-home.branchable.com/
# 
######

#FIXME: 
#X1. checkout files
#X2. Ask user: link everything? or link minimal? or link one by one?
#X3. Check if ~/bin is in the path and if not add it

#FIXME: build simple command to pull this script from github and run it.

#FIXME: add cowboy's shell prompt
#FIXME: should I modify this code so that it can run in a cron to auto pull files and create symlinks? yes

##########################################
# SETTINGS

# Set the dot directory and check for arguments
dotDir=$HOME/dotfiles
backupDir=$HOME/.dotfiles/backup
masterRepository=git://github.com/brettbatie/dotfiles

# comma delimited list for only creating a minimal set of symlinks
minimalSymlinkFiles=".vimrc,.gitconfig"

#
#########################################


function checkParameters {
    if [ $# -ge 1 ]; then
        if [ "$1" ==  "--help" ]; then
            echo "USAGE: $0 [/path/to/dotFileDirectory] [masterRepository]";
            echo "  dotFileDirectory: the directory that contains the static"\
                "files and will be linked to from the ~ directory."\
                "If the directory is not specified then ~/dotfiles is"\
                " used by default.\n"\
                "   masterRepository: the repository that will be used to "\
                "push & pull changes."
            exit 1
        fi
        dotDir = $1
        if [ "$2" != "" ]; then
            masterRepository=$2;
        fi
    fi

    # Verify that the dot directory exists
    if [ ! -d "$dotDir" ]; then
        echo "The dotfile directory ($dotDir) does not exist. Nothing to do."
        exit;
    fi

    # Trim the trailing slash from the dot directory (if there is one)
    if [[ $dotDir == */ ]]; then
        $dotDir=${dotDir%?}
    fi
}

function updateRepo {
    # if there is repo here update it, otherwise create the repo
    if [ -d "$dotDir/.git" ]; then
        echo "DOWNLOADING MASTER REPOSITORY"
        git clone $masterRepository $dotDir
    else
        echo "UPDATING MASTER REPOSITORY"
        (cd $dotDir && git pull $masterRepository)
    fi
}

# Add the given path to the $PATH, if it is not already there
function pathadd {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}



function symlinkOption {
    PS3="When creating the symlinks in ~ pointing to files $dotDir would you like to: "
options=("Create all symlinks" "Ask before creating each" "Use minimal list")
select opt in "${options[@]}"
do
    case $opt in
        "Create all symlinks")
            symlinkOption="all"
            ;;
        "Ask before creating each")
            symlinkOption="ask"
            ;;
        "Use minimal list")
            symlinkOption="minimal"
            ;;
        *) echo invalid option;;
    esac
done
}

function createSymLinks {

    # Determine if we are going to use a minimal list of files to symlink
    if [ "$symlinkOption" == "minimal" ]; then
        if ["$minimalSymlinkFiles" == "" ]; then
            echo "No minimal files to symlink, exiting."
            exit 1;
        fi
        minimalSymlinkFiles=${minimalSymlinkFiles/,/-name }
    else
        minimalSymlinkFiles=""
    fi

    # create the symlinks for every file in the given dotfile directory.
    for file in $(find "$dotDir" -type f $minimalSymlinkFiles -not -path "$dotDir/.hg/*" -not -path \
        "$dotDir/.git/*" -not -path "$backupDir" -not -path "$dotDir/apps.list"-not -path "$dotDir/bin/*"); do
        
        # get the file with a path relative to the dotDir
        relativeFile=${file#$dotDir} #remove $dotDir from $file

        # Remove the leading slash if there is one
        if [[ $relativeFile == /* ]]; then
            relativeFile=${relativeFile:1}
        fi

        if [ "$symlinkOption" == "ask" ]; then
            read -p "Would you like to create a symlink to $relativeFile" -n 1 -r
            # if not yes, then skip it
            if [[! $REPLY = ~ ^[Yy]$]]; then
                continue
            fi
        fi



        # Save existing files/symlinks to backup directory
        if [ -f $HOME/$relativeFile ]; then
            # create the backup directory, if necessary
            if [ ! -d "$backupDir" ]; then
                echo "Creating $backupDir for backup of any existing dotfiles in ~"
                mkdir -p "$backupDir"
            fi

            echo "Making backup of $relativeFile in $backupDir"
            mv $HOME/$relativeFile $backupDir/$relativeFile.$(date +"%Y%m%d%H%M")
        fi

        # Strip the filename from the relative Path
        destionationDir=$(dirname ${relativeFile})

        # Make sure that the destination directory exists
        if [ -d $destinationDir ]; then
            mkdir -p $destionationDir
        fi

        echo "Creating symlink ~/$relativeFile -> $file"
        ln -s "$file" "$HOME/$relativeFile"

        # if we are updating the bashrc file we should also run it to update the env
        if [ "$relativeFile" == ".bashrc" ]; then
            source bashrc
        fi
    done;
}




checkParameters
updateRepo
symlinkOption
# pathAdd $dotDir/bin
# createSymLinks