#!/bin/bash

# Globals
GITHUB_PREFIX="https://raw.githubusercontent.com"
PLUG_VIM="$GITHUB_PREFIX/junegunn/vim-plug/refs/heads/master/plug.vim"
VIMRC="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/.vimrc"
TMUX_CONF="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/.tmux.conf"
BASH_ALIASES="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/.bash_aliases"
GIT_PULL_NOTES="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/gitPullNotes.sh"
GIT_PUSH_NOTES="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/gitPushNotes.sh"
GIT_STATUS_NOTES="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/gitStatusNotes.sh"
KEYBIND_1="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/wm-keybind.dconf"
KEYBIND_2="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/media-keys.dconf"
TERMINAL_CONF="$GITHUB_PREFIX/goodfella-afk/pub_conf/refs/heads/main/terminal.dconf"

print_help()
{
	cat <<EOF

	Following arguments are supported:

	--proxy <http://host:port>   // have this as a first argument if behind a proxy
	--full (-f)                  // (ws - daily driver)
	--core (-c)                  // (server, remote)
	--get-configs                // (vim, tmux)
	--xsel                       // if --core is chosen but we want x11 frwrd

EOF
}

# Install vim, tmux
install_vim_tmux()
{
	if command -v apt > /dev/null 2>&1; then
		sudo apt install -y vim tmux
	else
		sudo dnf install -y vim tmux
	fi
}

# System clipboard / x11 forwarding
install_xsel()
{
	if command -v apt > /dev/null 2>&1; then
		sudo apt install -y xsel
	else
		sudo dnf install -y xsel
	fi
}

# .vimrc ; .tmux.conf ; .bash_aliases
get_configs()
{
	curl $VIMRC -o $HOME/.vimrc
	curl $TMUX_CONF -o $HOME/.tmux.conf
	curl $BASH_ALIASES -o $HOME/.bash_aliases
}

# plug.vim - for vimwiki and/or nerdtree
get_plugvim()
{
	mkdir -p $HOME/.vim/autoload
	curl $PLUG_VIM -o $HOME/.vim/autoload/plug.vim
}

# gitPullNotes ; gitPushNotes ; gitStatusNotes - helper scripts
get_helper_scripts()
{
	mkdir -p $HOME/.config/helper-scripts
	curl $GIT_PULL_NOTES -o $HOME/.config/helper-scripts/gitPullNotes.sh
	curl $GIT_PUSH_NOTES -o $HOME/.config/helper-scripts/gitPushNotes.sh
	curl $GIT_STATUS_NOTES -o $HOME/.config/helper-scripts/gitStatusNotes.sh
}


# Navigation keybinds and terminal config
import_keybinds()
{
	curl $KEYBIND_1 -o /tmp/wm-keybind.dconf
	curl $KEYBIND_2 -o /tmp/media-keys.dconf
	curl $TERMINAL_CONF -o /tmp/terminal.dconf
	dconf load /org/gnome/desktop/wm/keybindings/ \
	   	< /tmp/wm-keybind.dconf
	dconf load /org/gnome/settings-daemon/plugins/media-keys/ \
		< /tmp/media-keys.dconf
	dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ \
		< /tmp/terminal.dconf
	rm /tmp/wm-keybind.dconf
	rm /tmp/media-keys.dconf
	rm /tmp/terminal.dconf
}

# Full (workstation)
full_setup()
{
	install_vim_tmux && get_configs && \
		get_plugvim && import_keybinds && \
		install_xsel && get_helper_scripts
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
				--proxy|-f|--full|-c|--core|--xsel|--get-configs)
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
			--xsel)
				install_xsel || exit 1
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

#   install_vim_tmux   ; install_xsel      ; get_configs
#   get_plugvim        ; import_keybinds   ; full_setup
#   core_setup         ; check_args        ; run_args
#   print_help

# Main
check_args $@
