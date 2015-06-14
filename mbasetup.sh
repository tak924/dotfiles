#!/bin/bash

for dotfile in .??*
do
    if [ $dotfile != '.git' ] && [ $dotfile != '.DS_Store' ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
    fi      
done
