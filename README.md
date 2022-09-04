Neovim Docker
=============

My neovim setup in docker

## What Does It Do?

Basically it's a container based on Ubuntu 22.04 that is installed with neovim as well as the following components:

- git
- python3
- nodejs 12

I configured neovim and installed some plugins in it.

## Building

Build the image with: `docker build -t neovim-docker .`

## Running

To run, for example do this: `docker run --rm -it neovim-docker`.

The command above will open a terminal inside the container you can type `nvim` to open neovim or do any other stuff.

