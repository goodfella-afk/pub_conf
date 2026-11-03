#.bash_profile

# vmware aliases
alias start-deb="vmrun -T ws start "/home/bigfella/vmware/debian_dev/debian_dev.vmx" nogui"
alias stop-deb="vmrun -T ws stop "/home/bigfella/vmware/debian_dev/debian_dev.vmx" soft"

# SSH aliases
alias goto-kali="ssh -i /home/bigfella/Documents/keys/kali kali@172.16.15.128"
# -Y is safer option then -X for X11 forwarding
alias goto-deb="ssh -i /home/bigfella/Documents/keys/debian_dev dev@172.16.15.131"
alias goto-hserver="ssh -p 1810 -i /home/bigfella/Documents/keys/hserver bigfella@server.nikolazivkovic.me"

# make my life easier
export debian_dev=172.16.15.131
export kali=172.16.15.128
export hserver=$(dig @1.1.1.1 +short server.nikolazivkovic.me | head -n1)

# vimwiki notes helpers
alias note-push="/home/bigfella/.config/helper-scripts/./gitPushNotes.sh"
alias note-pull="/home/bigfella/.config/helper-scripts/./gitPullNotes.sh"
alias note-status="/home/bigfella/.config/helper-scripts/./gitStatusNotes.sh"
alias wiki="python3 -m http.server -b localhost -d /home/bigfella/Documents/notes/"

# default editor
export EDITOR=/usr/bin/vim

# color my shiet
alias ip="ip -c=auto"

