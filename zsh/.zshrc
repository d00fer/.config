bindkey -v
alias vi='nvim'
mpvbg() { nohup mpv "$@" > /dev/null 2>&1 & disown }
export COLORTERM=truecolor
eval "$(/opt/homebrew/bin/brew shellenv)"
typeset -U path fpath

export GOPATH="$HOME/.go"
path=("/usr/local/go/bin" "$HOME/.local/bin" "$HOME/.go/bin" "/opt/homebrew/opt/ruby/bin" "/opt/homebrew/lib/ruby/gems/4.0.0/bin" $path)
fpath=("$HOME/.config/zsh/completion" $fpath)

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

autoload -U +X bashcompinit && bashcompinit

git_prompt() {
  local b=$(git branch --show-current 2>/dev/null)
  [[ -z $b ]] && return
  local git_status indicators=""
  git_status=$(git status --porcelain 2>/dev/null)
  grep -q '^[MADRC]' <<< "$git_status" && indicators+="+"
  grep -q '^.[MD]'   <<< "$git_status" && indicators+="*"
  grep -q '^??'      <<< "$git_status" && indicators+="?"
  print "($b${indicators:+ $indicators}) "
}
setopt PROMPT_SUBST
PROMPT='%n@%m [%1~] $(git_prompt)%# '
