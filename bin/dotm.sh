#!/bin/bash
#####
# Creates symlinks in the home directory pointing to all files in the given 
# dotfiles directory.
######

# Set the dot directory and check for arguments
dotDir=$HOME/dotfiles
backupDir=$HOME/.dotfiles_backup

if [ $# -eq 1 ]; then
    if [ "$1" ==  "--help" ]; then
        echo "USAGE: $0 [/path/to/dotFileDirectory]";
        echo "  dotFileDirectory: the directory that contains the static"\
            "files and will be linked to from the ~ directory."\
            "If the directory is not specified then ~/dotfiles is"\
            " used by default"
        exit 1
    fi
    dotDir = $1
fi

# Verify that the dot directory exists
if [ ! -d "$dotDir" ]; then
    echo "The dotfile directory ($dotDir) does not exist. Nothing to do."
    exit;
fi


if [ ! -d "$backupDir" ]; then
    echo "Creating $backupDir for backup of any existing dotfiles in ~"
    mkdir -p $backupDir
fi

# create the symlinks for every file in the given dotfile directory. 
for file in $(find "$dotDir" -type f -not -path "*/.hg/*" -not -path \
    "*/.git/*" ); do
    
    # get the file with a path relative to the dotDir
    relativeFile=${file#$dotDir} #remove $dotDir from $file

    #remove the leading slash if there is one
    if [[ $relativeFile == /* ]]; then
        relativeFile=${relativeFile:1}
    fi

    # Save existing files to backup directory
    if [ -f $HOME/$relativeFile ]; then
        echo "Making backup of $relativeFile in $backupDir"
        mv $HOME/$relativeFile $backupDir
    fi

    # check if the destination path needs created. If the file is to be put in ~/some/dir/.configfile, we might need to create /some/dir
    # will need to strip the filename from the end of relative Path

    echo "Creating symlink ~/$relativeFile -> $file"
    ln -s "$file" "$HOME/$relativeFile"
done;