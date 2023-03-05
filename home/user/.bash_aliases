aliases_loaded=true
[ -z "$BSDir" ] && [ -d "$HOME/Documents/Programming/Bash" ] && export BSDir="$HOME/Documents/Programming/Bash"
if [ -z "$OS" ]; then
	if [ -x "$BSDir/determine.sh" ]; then
		OS="`$BSDir/determine.sh -o`"
	else
		if (hash lsb_release 2>/dev/null); then
			OS="$(lsb_release -si)"
		else
			OS="$(uname -r)"
		fi
	fi
	if [[ "${OS^^}" =~ UBUNTU ]]; then
		OS=Ubuntu
	elif [[ "${OS^^}" =~ ARCH ]]; then
		OS=Arch
	elif [[ "${OS^^}" =~ MANJARO ]]; then
		OS="Manjaro"
	elif [[ "${OS^^}" =~ MINT ]]; then
		OS="Mint"
	elif [[ "${OS^^}" =~ NEON ]]; then
		OS=Neon
	fi
fi
export OS
if [ -f ~/.bash_"${OS,,}"_aliases ]; then
	. ~/.bash_"${OS,,}"_aliases
fi
[ -z "$DE" ] && [ -x "$BSDir/determine.sh" ] && export DE="`$BSDir/determine.sh -d`"
NETWORKCARDNAME=$(ls -1 /sys/class/net | grep -o '^w[^ ]*' | head -n1)
INTELLIJPATH=$(ls -1pv "$HOME"/Documents/Programming/ | grep -iE ".*idea.*/" | tail -n1)
PYCHARMPATH=$(ls -1pv "$HOME"/Documents/Programming/ | grep -iE ".*pycharm.*/" | tail -n1)
CLIONPATH=$(ls -1pv "$HOME"/Documents/Programming/ | grep -iE ".*clion.*/" | tail -n1)
RIDERPATH=$(ls -1pv "$HOME"/Documents/Programming/ | grep -iE ".*rider.*/" | tail -n1)
BATPATH=$(upower -e | grep -i BAT)
if [ ! -z "$INTELLIJPATH" ]; then
	alias idea="$HOME/Documents/Programming/'${INTELLIJPATH::${#INTELLIJPATH}-1}'/bin/idea.sh"
elif hash idea.sh &>/dev/null; then
	alias idea="idea.sh"
fi
if [ ! -z "$PYCHARMPATH" ]; then
	alias pycharm="$HOME/Documents/Programming/'${PYCHARMPATH::${#PYCHARMPATH}-1}'/bin/pycharm.sh"
fi
if [ ! -z "$CLIONPATH" ]; then
	alias clion="$HOME/Documents/Programming/'${CLIONPATH::${#CLIONPATH}-1}'/bin/clion.sh"
fi
if [ ! -z "$RIDERPATH" ]; then
	alias rider="$HOME/Documents/Programming/'${RIDERPATH::${#RIDERPATH}-1}'/bin/rider.sh"
fi
alias tlauncher="export PATH=/usr/lib/jvm/java-8-jre/jre/bin:$PATH && java -jar $HOME/Games/TLauncher.jar"
alias syncfile="python3 $HOME/Documents/Programming/Python/Syncfile/syncfile.py"
if [[ "$DE" =~ (Gnome|Mint) ]] && pgrep xscreensaver &>/dev/null; then
	alias lock="xscreensaver-command -lock"
elif [[ "$DE" == KDE ]]; then
	alias lock="qdbus org.kde.screensaver /ScreenSaver SetActive true"
elif [[ "$DE" == Cinnamon ]]; then
	alias lock="cinnamon-screensaver-command --lock"
else
	alias lock="vlock"
fi
# hash rslsync &>/dev/null && alias rslsync="[[ ! \"`stat -c %U /run/rslsync/`\" == \"$HOME\" ]] && sudo chown -R \"$USER\" /run/rslsync; rslsync --config ~/.config/rslsync/rslsync.conf"
hash subl3 &>/dev/null && alias subl=subl3
hash PCSX2 &>/dev/null && alias pcsx2=PCSX2
hash FBReader &>/dev/null && alias fbreader=FBReader
hash vivaldi-stable && alias vivaldi=vivaldi-stable
alias home_keybind_on="dconf write /org/gnome/desktop/wm/keybindings/show-desktop '[\"Home\"]'"
alias home_keybind_off="dconf write /org/gnome/desktop/wm/keybindings/show-desktop '[\"\"]'"
alias m='media'
alias p='play'
alias g='game'
alias mc='m c'
alias mw='m w'
if hash calc &>/dev/null; then
	pi=`calc 'pi()'`
	e=`calc 'exp(1)'`
fi
alias killallwine="ps -A -o'%p %c' | grep -iE '(wine|\\.exe|win32|win64)'| sed -e 's/^\ *//g' | cut -d' ' -f1 | killall -p"
