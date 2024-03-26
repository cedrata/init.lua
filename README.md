# Nvim configuration
This is my neovim configuration, [ThePrimeagen](https://www.youtube.com/watch?v=w7i4amO_zaE) nvim configuration has been use as a starting point for this one.

# Requirements
Some packages are required before the configuration phase of neovim:
- [ripgrep](https://github.com/BurntSushi/ripgrep) to enable `Live Grep` for [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [golang](https://go.dev/doc/install) required for delve
- [pyenv](https://github.com/pyenv/pyenv) 
- [pipenv](https://github.com/pypa/pipenv)
- npm (I like to do install some node version with [nvm](https://github.com/nvm-sh/nvm))
- golangci-lint `brew install golangci-lint` (a configuration file may be required as ~/.golangci-lint, check documentation)
- cargo (some of the plugins use rust/cargo)

After the packages installation it is required to do some more preliminary operations
- Create a new virtualenv where to install `debugpy` enabling python debug.
Type in your console:
```bash
mkdir ~/.virtualenvs
python -m venv debugpy
~/.virtualenvs/debugpy python -m pip install debugpy
```

- [nextest](https://nexte.st) if you are on mac simply install `brew install cargo-nextest`


# Common issues and solutions
- tresitter returns errors somewhere, currently happened in: fugitive commit console
solution: in vim type `: TSUpdate`

# Required improvements
replace `none-ls`, follow [this guide](https://andrewcourter.substack.com/p/configure-linting-formatting-and)
