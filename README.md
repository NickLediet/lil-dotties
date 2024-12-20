`# Lil Dotties

## Installation
```bash
 curl -L https://raw.githubusercontent.com/NickLediet/lil-dotties/main/install.sh | bash
```

## Pulling updates
Sometimes you can be met with errors that git fails to resolve a merge.  I am currently providing a `-c pull.rebase=true` flag to the `git pull` alias and it seems to do the job.  Likely could set this globally, but rebasing scares me these days. 
```sh
config -c pull.rebase=true pull
```

## Resources

- Tmux Dependencies
    - [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm)
    - [Tmux Sensible Plugin](https://github.com/tmux-plugins/tmux-sensible)
    - [Catppuccin Tmux Theme](https://github.com/catppuccin/tmux)
- Zsh Dependencies
    - [zinit Plugin Manager](https://github.com/zdharma-continuum/zinit)
    - [Powerlevel 10k](https://github.com/romkatv/powerlevel10k)
    - [Oh-my-zsh plugins](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins)
    - [zsh Completions](https://github.com/zsh-users/zsh-completions)
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- NeoVim Dependencies
    - [NvChad](https://github.com/NvChad/NvChad)
    - [NvChad (Un)Installation Guide](https://nvchad.com/docs/quickstart/install)
- General Utilities
    - [FZF](https://github.com/junegunn/fzf)
    - [JQ](https://jqlang.github.io/jq/)
    - [YQ](https://github.com/mikefarah/yq)
    - [zoxide](https://github.com/ajeetdsouza/zoxide)
    - [Git Leaks](https://github.com/gitleaks/gitleaks)

