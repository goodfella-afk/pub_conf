#!/bin/bash

# Globals
GITHUB_PREFIX="https://raw.githubusercontent.com/goodfella-afk/pub_conf/refs/heads/main"

# Wkstn globals
WKSTN_ALACRITTY_TOML="$GITHUB_PREFIX/wkstn/alacritty/alacritty.toml"

WKSTN_BASH_ALIAS="$GITHUB_PREFIX/wkstn/.bash_aliases"
WKSTN_TMUX_CONF="$GITHUB_PREFIX/wkstn/.tmux.conf"

WKSTN_INIT_LUA="$GITHUB_PREFIX/wkstn/.config/nvim/init.lua"
WKSTN_CONFIGS_LUA="$GITHUB_PREFIX/wkstn/.config/nvim/lua/configs.lua"
WKSTN_KEYMAPS_LUA="$GITHUB_PREFIX/wkstn/.config/nvim/lua/keymaps.lua"
WKSTN_LAZY_SETUP_LUA="$GITHUB_PREFIX/wkstn/.config/nvim/lua/lazy-setup.lua"
WKSTN_TREESITTER_LUA="$GITHUB_PREFIX/wkstn/.config/nvim/lua/plugins/treesitter.lua"
WKSTN_VIMWIKI_LUA="$GITHUB_PREFIX/wkstn/.config/nvim/lua/plugins/vimwiki.lua"

WKSTN_GIT_PULL_NOTES="$GITHUB_PREFIX/wkstn/helper-scripts/gitPullNotes.sh"
WKSTN_GIT_PUSH_NOTES="$GITHUB_PREFIX/wkstn/helper-scripts/gitPushNotes.sh"
WKSTN_GIT_STATUS_NOTES="$GITHUB_PREFIX/wkstn/helper-scripts/gitStatusNotes.sh"


# Dev globals
DEV_TMUX_CONF="$GITHUB_PREFIX/dev/.tmux.conf"

DEV_INIT_LUA="$GITHUB_PREFIX/dev/.config/nvim/init.lua"
DEV_CONFIGS_LUA="$GITHUB_PREFIX/dev/.config/nvim/lua/configs.lua"
DEV_KEYMAPS_LUA="$GITHUB_PREFIX/dev/.config/nvim/lua/keymaps.lua"
DEV_PLUGINS_LUA="$GITHUB_PREFIX/dev/.config/nvim/lua/plugins.lua"
DEV_TREESITTER_LUA="$GITHUB_PREFIX/dev/.config/nvim/lua/plugins/treesitter.lua"
DEV_LSP_LUA="$GITHUB_PREFIX/dev/.config/nvim/lua/lsp.lua"
DEV_CLANGD_LUA="$GITHUB_PREFIX/dev/.config/nvim/lua/lsp/clangd.lua"
DEV_ROSLYN_LS_LUA="$GITHUB_PREFIX/dev/.config/nvim/lua/lsp/roslyn_ls.lua"

# Legacy globals
LEGACY_VIMRC="$GITHUB_PREFIX/legacy/.vimrc"
LEGACY_TMUX_VIMRC="$GITHUB_PREFIX/legacy/.tmux-vimrc.conf"

print_help()
{
	cat <<EOF

	Following arguments are supported:

	--proxy <http://host:port>   // have this as a first argument if behind a proxy
	--wkstn (-w)                 // (wkstn - daily driver)
	--dev (-d)					 // (dev)
	--get-configs                // (nvim, tmux, alacritty, aliases - local remote dev stations)
	--get-vimrc                  // (.vimrc and .tmux.conf - remote/pluginless non-dev work)

EOF
}

# Install vim, tmux
install_vim_tmux()
{
	if command -v apt > /dev/null 2>&1; then
		sudo apt install -y neovim tmux
	else
		sudo dnf install -y neovim tmux
	fi
}

# .vimrc ; .tmux.conf ; .bash_aliases
get_configs()
{
	mkdir -p $HOME/.config/nvim/lua/plugins
	mkdir -p $HOME/.config/alacritty
	curl $ALACRITTY_TOML -o $HOME/.config/alacritty/alacritty.toml
	curl $INIT_LUA -o $HOME/.config/nvim/init.lua
	curl $TREESITTER_LUA -o $HOME/.config/nvim/lua/plugins/treesitter.lua
	curl $VIMWIKI_LUA -o $HOME/.config/nvim/lua/plugins/vimwiki.lua
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

# Core (servers, remote - dev)
core_setup()
{
	install_vim_tmux && get_configs
}

# Get .vimrc for remote/pluginless work
get_vimrc()
{
	curl $LEGACY_VIMRC -o $HOME/.vimrc
	curl $LEGACY_TMUX_VIMRC -o $HOME/.tmux.conf
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
				--proxy|-f|--full|-c|--core|--get-configs|--get-vimrc)
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
			--get-vimrc)
				get_vimrc || exit 1
				shift
				;;
		esac
	done
}

# Valid functions are

#   print_help	; install_vim_tmux  ; get_configs
#	full_setup  ; core_setup		; get_vimrc
#   check_args  ; run_args

# Main
check_args $@
