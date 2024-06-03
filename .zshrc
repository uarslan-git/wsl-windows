export EDITOR=/usr/bin/nvim
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	git
	zsh-nvm
	zsh-syntax-highlighting
	zsh-autosuggestions
	fzf-zsh-plugin
	git-auto-fetch
	zsh-nvm
	)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias backup="pushd ~/; dconf-save; ga -u; gcd; gp; popd"
alias cal="cal -wm"
alias ga="git add"
alias gb="git branch -a"
alias gc="git commit -m"
alias gcd="git commit -m '$(date)'"
alias gco="git checkout"
alias gl="git log --graph --pretty=oneline --abbrev-commit"
alias gp="git push"
alias gs="git status"
alias ra="ranger"
alias sudo="sudo "
alias vi="nvim"
alias vim="nvim"
alias nf="neofetch"
