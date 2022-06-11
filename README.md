# My Dotfiles

![dotfiles](https://dotfiles.github.io/images/dotfiles-logo.png)

Hi! These are my dotfiles that I use every day. If you find something
interesting, go ahead and take whatever you want from my dotfiles.

It is managed using [yadm](https://github.com/TheLocehiliosan/yadm/), a dotfile
manager. This makes it simple to set up a new computer with these files. In
order to set up a new system with these dotfiles, do the following:

## Use

First of all you need yadm, this can be installed on macOS via homebrew or on $linux via the package manager.

## macOS

### Install Homebrew

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### Install tools with Homebrew on macOS

```shell
brew bundle install --file=.Brewfile
```

## Install tools on ArchLinux

```shell
xargs pacman -S --needed --noconfirm < [.pacmanfile](./.pacmanfile)
```

## Clone dotfiles with [yadm](https://yadm.io/)

```shell
$ yadm clone --bootstrap https://github.com/steinbrueckri/dotfiles
Initialized empty shared Git repository in /steinbrueckri/.config/yadm/repo.git/
remote: Enumerating objects: 295, done.
remote: Counting objects: 100% (283/283), done.
remote: Compressing objects: 100% (133/133), done.
remote: Total 295 (delta 119), reused 282 (delta 118), pack-reused 12
Receiving objects: 100% (295/295), 183.96 KiB | 399.00 KiB/s, done.
Resolving deltas: 100% (120/120), done.
From https://github.com/steinbrueckri/dotfiles
 * [new branch]      master     -> origin/master
Executing /steinbrueckri/.config/yadm/bootstrap
```

## Apply other OS Settings

My macOS settings can you apply with the [osx_settings.sh](./.dotfileassets/osx_settings.sh)

## Hardware

As my main device i use Macbook Pro 2019 ...

```shell
$ system_profiler SPHardwareDataType | grep -v "UDID\|UUID\|Serial"
Hardware:

    Hardware Overview:

      Model Name: MacBook Pro
      Model Identifier: MacBookPro16,1
      Processor Name: 6-Core Intel Core i7
      Processor Speed: 2,6 GHz
      Number of Processors: 1
      Total Number of Cores: 6
      L2 Cache (per Core): 256 KB
      L3 Cache: 12 MB
      Hyper-Threading Technology: Enabled
      Memory: 32 GB
      System Firmware Version: 1554.140.20.0.0 (iBridge: 18.16.14759.0.1,0)
      Activation Lock Status: Disabled
```

As Keyboard i use a [Kinesis Advantage2](https://kinesis-ergo.com/shop/advantage2/)
with the keycaps from [keycap.sh](https://keycap.sh/) and my Keyboard layouts and macros
for it can be found in [`.dotfileassets/advantage2`](./.dotfileassets/advantage2/).

![Keyboard](./.dotfileassets/keyboard.jpg)

## Screenshots

![Screenshot-1](./.dotfileassets/screenshot-1.png)

![Screenshot-2](./.dotfileassets/screenshot-2.png)
