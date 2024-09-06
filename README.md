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

- [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm)
- [Tmux Sensible Plugin](https://github.com/tmux-plugins/tmux-sensible)
