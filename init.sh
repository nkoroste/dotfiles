#!/usr/bin/env bash

function runDots() {
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until the script has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Run sections based on command line arguments
    for ARG in "$@"
    do
        if [ $ARG == "bootstrap" ] || [ $ARG == "all" ]; then
            echo ""
            echo "------------------------------"
            echo "Syncing the dotfiles repo to your local machine."
            echo "------------------------------"
            echo ""
            source bootstrap.sh
        fi
        if [ $ARG == "brew" ] || [ $ARG == "all" ]; then
            # Run the brew.sh Script
            # For a full listing of installed formulae and apps, refer to
            # the commented brew.sh source file directly and tweak it to
            # suit your needs.
            echo ""
            echo "------------------------------"
            echo "Installing Homebrew along with some common formulae and apps."
            echo "This might take a while to complete, as some formulae need to be installed from source."
            echo "------------------------------"
            echo ""
            ./brew.sh
        fi
        if [ $ARG == "android" ] || [ $ARG == "all" ]; then
            # Run the android.sh Script
            echo "------------------------------"
            echo "Setting up Android development environment."
            echo "------------------------------"
            echo ""
            ./android.sh
        fi
		if [ $ARG == ".macos" ] || [ $ARG == "all" ]; then
            # Run the macos.sh Script
            # I strongly suggest you read through the commented osx.sh
            # source file and tweak any settings based on your personal
            # preferences. The script defaults are intended for you to
            # customize. For example, if you are not running an SSD you
            # might want to change some of the settings listed in the
            # SSD section.
            echo ""
            echo "------------------------------"
            echo "Setting sensible macos defaults."
            echo "------------------------------"
            echo ""
            ./.macos
        fi
    done

    echo "------------------------------"
    echo "Completed running .dots, restart your computer to ensure all updates take effect"
    echo "------------------------------"
}

read -p "This script may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    runDots $@
fi;

unset runDots;
