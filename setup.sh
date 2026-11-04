#!/bin/bash

# Globals
GITHUB_PREFIX="https://raw.githubusercontent.com"
INIT_LUA="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/init.lua"
ALACRITTY_TOML="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/alacritty.toml"
TMUX_CONF="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/.tmux.conf"
BASH_ALIAS="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/.bash_aliases"
GIT_PULL_NOTES="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/gitPullNotes.sh"
GIT_PUSH_NOTES="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/gitPushNotes.sh"
GIT_STATUS_NOTES="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/gitStatusNotes.sh"

print_help()
{
	cat <<EOF

	Following arguments are supported:

	--proxy <http://host:port>   // have this as a first argument if behind a proxy
	--full (-f)                  // (ws - daily driver)
	--core (-c)                  // (server, remote)
	--get-configs                // (vim, tmux)

EOF
}

# Install vim, tmux
install_vim_tmux()
{
	if command -v apt > /dev/null 2>&1; then
		sudo apt install -y nvim tmux
	else
		sudo dnf install -y nvim tmux
	fi
}

# .vimrc ; .tmux.conf ; .bash_aliases
get_configs()
{
	mkdir -p $HOME/.config/nvim
	mkdir -p $HOME/.config/alacritty
	curl $ALACRITTY_TOML -o $HOME/.config/alacritty/alacritty.toml
	curl $INIT_LUA -o $HOME/.config/nvim/init.lua
	curl $TMUX_CONF -o $HOME/.tmux.conf
	curl $BASH_ALIAS -o $HOME/.bash_aliases
}

# gitPullNotes ; gitPushNotes ; gitStatusNotes - helper scripts
get_helper_scripts()
{
	mkdir -p $HOME/.config/helper-scripts
	curl $GIT_PULL_NOTES -o $HOME/.config/helper-scripts/gitPullNotes.sh
	curl $GIT_PUSH_NOTES -o $HOME/.config/helper-scripts/gitPushNotes.sh
	curl $GIT_STATUS_NOTES -o $HOME/.config/helper-scripts/gitStatusNotes.sh
}

# Full (workstation)
full_setup()
{
	install_vim_tmux && get_configs && get_helper_scripts
}

# Core (servers, remote)
core_setup()
{
	install_vim_tmux && get_configs
}

check_args()
{
	if [[ $# -gt 0 ]]; then
		args=("$@")
		while [[ $# -gt 0 ]]; do
			case $1 in
				-h|--help)
					print_help
					exit 0
					;;
				--proxy|-f|--full|-c|--core|--get-configs)
					;;
				*)
					echo -e "\n"$1" is a bad argument, check --help / -h\n"
					exit 1
			esac

			# shift 2 args when we process proxy
			if [[ $1 == "--proxy" ]]; then
				shift 2
			else
				shift
			fi
		done
	else
		echo "Missing arguments, check --help / -h"
		exit 1
	fi 

	set -- "${args[@]}" && run_args $@
}

run_args()
{
	while [[ $# -gt 0 ]]; do
		case $1 in
			--proxy)
				export http_proxy="$2"
				export https_proxy="$2"
				shift 2
				;;
			-f|--full)
				full_setup || exit 1
				shift
				;;
			-c|--core)
				core_setup || exit 1
				shift
				;;
			--get-configs)
				get_configs || exit 1
				shift
				;;
		esac
	done
}

# Valid functions are

#   print_help	; install_vim_tmux  ; get_configs
#	full_setup  ; core_setup		; check_args
#   run_args

# Main
check_args $@
