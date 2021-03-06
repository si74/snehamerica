#!/bin/bash

# Ask for administrator password upfront
sudo -v

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Fix any brew conflicts, although shouldn't be needed with a new install
brew doctor

# Update homebrew recipes
brew update

if test ! $(which direnv); then
  echo "Installing direnv"
  brew install direnv
fi

# golang
if test ! $(which go); then
  echo "Installing golang"
  brew install go
fi

if test ! $(which glide); then
  echo "Installing glide"
  brew install glide
fi

if test ! $(which goenv); then
  echo "Installing goenv"
  brew install goenv
fi

goenv install 1.9.2
goenv install 1.10.1

# installing pip and virtualenv for python development
if test ! $(which python3); then
  echo "Installing python3"
  brew install python3
fi

if test ! $(which pip); then
  echo "Installing pip"
  brew install pip
fi

if test ! $(which virtualenv); then
  echo "Installing virtualenv"
  pip install virtualenv
fi

#create directory in which to store virtual environments
echo "Creating python virtual environments..."
mkdir ~/.virtualenvs
virtualenv -p python py2 #this should be python2
virtualenv -p python3 py3

# Node/npm
# if test ! $(which npm); then
# 	echo "Installing Node..."
# 	brew install node
# fi

# Adjust PATH
# echo "Adjusting PATH"
# export NODE_PATH="/usr/local/lib/node"
# export PATH="/usr/local/share/npm/bin:$PATH"

# Grunt
# echo "Installing Grunt..."
# npm install -g grunt-cli
#
# Bower
# echo "Installing Bower..."
# npm install -g bower
#
# Yeoman
# echo "Installing Yeoman..."
# npm install -g yo
# npm install -g generator-webapp
#
# Sass
# echo "Installing Sass..."
# gem install sass
#
# Compass
# echo "Installing compass..."
# gem update --system
# gem install compass
#
# Spinners
# echo "Installing spinners and sass-css-importer..."
# gem install spinners
# gem install --pre sass-css-importer

# Quick install for apps
brew tap caskroom/cask
brew install brew-cask

apps=(
  ansible
	#spectacle
	slack
  #appcleaner
	firefox
	google-chrome
	google-drive
	spotify
	atom
	#vlc
	#quicklook-json
	#qlcolorcode
	#qlstephen
	virtualbox
	evernote
	#dropbox
	#cyberduck
	skype
	#blender
	#balsamic
	#macaw
	#adobe-photoshop-cc
	google-drive
	omni-disk-sweeper
	#mongodb
  vagrant
  vagrant-manager
  iterm2
  docker
  docker-machine
  docker-compose
	#dash
  #doctl
  terraform
  cleanmymac3
  todoist
  tomatoone
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Apps installed are symlinked to /Applications"
echo "Actual files are in /opt/homebrew-cask/Caskroom/"

echo "Making text selectable in quick view"
defaults write com.apple.finder QLEnableTextSelection -bool true && killall Finder

# Setup docker for development
echo "Setting up docker and docker-machine"
docker-machine create --driver virtualbox \
--virtualbox-host-dns-resolver dev

eval "$(docker-machine env dev)"

# Create /sites/ directory - commented out b/c this should already be created prior to running script
#echo "Creating /sites/"
#sudo mkdir ~/sites/

# Create gocode directory for development
echo "Creating gocode subfolder"
cd "$HOME/sites"
sudo mkdir gocode

# echo "Setting up gocode .envrc file"
# This is commented out b/c the attached envrc file should be moved here
# cd "$HOME/sites/gocode"
# echo export GOPATH="$HOME/sites/gocode" > .envrc
# direnv allow

echo "Setting up golang sub-directories"
sudo mkdir src
sudo mkdir bin
sudo mkdir pkg

echo "Setting up relevant github sub-directories"
cd "$HOME/sites/gocode/src"
mkdir github.com

echo "Installing golint - not gofmt and go vet should already work"
go get -u github.com/golang/lint/golint
mv "$HOME/sites/gocode/bin/golint" "/usr/local/bin/golint"

# Run CLI setup script
chmod +x "$HOME/sites/snehamerica/clisetup.sh"
./clisetup.sh

echo "Done!"
