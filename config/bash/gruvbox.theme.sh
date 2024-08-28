#! bash oh-my-bash.module

yellow="\[$(tput setaf 214)\]"
green="\[$(tput setaf 142)\]"
red="\[$(tput setaf 167)\]"
orange="\[$(tput setaf 208)\]"

OSH_THEME_GIT_PROMPT_DIRTY="✗"
OSH_THEME_GIT_PROMPT_CLEAN="✓"

# Nicely formatted terminal prompt
function _omb_theme_half_way_prompt_scm {
  local CHAR=$(scm_char)
  if [[ $CHAR != "$SCM_NONE_CHAR" ]]; then
    printf '%s' " on ${yellow}$(git_current_branch)$(parse_git_dirty)${_omb_prompt_normal} "
  fi
}

function _omb_theme_PROMPT_COMMAND {
  local ps_username="${red}\u${_omb_prompt_normal}"
  local ps_path="${orange}\w${_omb_prompt_normal}"
  local ps_user_mark="${green}λ${_omb_prompt_normal}"

  local python_venv
  _omb_prompt_get_python_venv

  PS1="$ps_username in $python_venv$ps_path$(_omb_theme_half_way_prompt_scm) $ps_user_mark "
}

OMB_PROMPT_SHOW_PYTHON_VENV=${OMB_PROMPT_SHOW_PYTHON_VENV:-false}
OMB_PROMPT_VIRTUALENV_FORMAT="${_omb_prompt_olive}(%s)${_omb_prompt_reset_color} "

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
