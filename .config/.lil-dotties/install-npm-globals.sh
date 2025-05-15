#!/usr/bin/env bash


# Notes on why packages are required:
# typescript,typescript-language-server = For neovim lsp [ts_ls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls)
# graphql = For neovim lsp [graphql](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#graphql)

npm i -g \
  typescript typescript-language-server \
  graphql-language-service-cli
