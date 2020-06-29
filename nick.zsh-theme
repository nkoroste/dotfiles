function get_pwd() { print -D $PWD }

# Load version control information
setopt prompt_subst
# # Format the vcs_info_msg_0_ variable
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M'
zstyle ':vcs_info:*' unstagedstr 'M'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
  '%F{5}[%F{2}%b%F{5}] %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git
# Slows down prompt:
# +vi-git-untracked() {
#   if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#   [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
#   hook_com[unstaged]+='%F{1}??%f'
# fi
# }

precmd () {
    vcs_info
    print -rP '$fg[cyan]%n: $fg[yellow]$(get_pwd)%{$reset_color%} ${vcs_info_msg_0_}'
}

PROMPT='%{$reset_color%}'
