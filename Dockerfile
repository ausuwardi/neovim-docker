FROM ubuntu:22.04

ARG C_GROUP_NAME=theuser
ARG C_USER_NAME=theuser
ARG C_HOME_DIR=/home/theuser
ARG NEOVIM_VERSION=0.7.2

RUN set -x; \
    apt-get update \
    && apt-get install -y --no-install-recommends wget curl \
            git \
            python3 python3-dev python3-venv pipenv pylint \
            nodejs npm \
            less jq bat ranger fzf ripgrep \
    && apt-get clean \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN curl -fLsSo nvim-linux64.deb https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim-linux64.deb \
    && dpkg -i nvim-linux64.deb \
    && rm -f nvim-linux64.deb

RUN npm install -g neovim pyright

RUN groupadd $C_GROUP_NAME \
    && useradd -m -d $C_HOME_DIR -g $C_GROUP_NAME -s /bin/bash $C_USER_NAME

USER $C_USER_NAME
WORKDIR $C_HOME_DIR

COPY --chown=$C_USER_NAME:$C_GROUP_NAME ./src/config/nvim $C_HOME_DIR/.config/nvim

# This is a workaround because autoload is note working properly in neovim 0.7
RUN curl -fLsSo $C_HOME_DIR/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#RUN nvim -es -i NONE -u $C_HOME_DIR/.config/nvim/vim-plug/plugins.vim -V  -c "qa"

