# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

######################################## USEFUL SHIT  ########################################
# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth:erasedups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# show potential good files when trying to cd in a non existant dir
shopt -s cdspell

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

iatest=$(expr index "$-" i)
# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

#######################################  LS    ############################################
alias l='ls --color=always'            
alias l.='ls -d .* --color=always'     
alias ll='ls -lhrt --color=always'     
alias lla='ls -lhrta --color=always'     
alias lld='ls -lUd */ --color=always'  
alias la='ls -a --color=always'        

########################################   APT   ########################################
alias sagi='sudo /bin/apt-get install'
alias ragi='sudo /bin/apt-get remove'
alias sagu='sudo /bin/apt-get update && sudo /bin/apt-get upgrade'
alias saclean='sudo /bin/apt-get autoclean && sudo /bin/apt-get autoremove && sudo /bin/apt-get clean'

########################################   CD    ########################################
alias bd='cd "$OLDPWD"' # equivalent to : cd -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cdd='cd ~/Documents && c && ll'
alias cdmc='cd ~/Documents/master-courses && c && ll'
# mkdir + cd
mkdircd() { [ $# = 1 ] && mkdir -p "$@" && cd "$@" || echo "Error - no directory passed!"; }
# Autoriser le cd'ing sans taper la partie cd si la version bash> = 4
# [ ${BASH_VERSINFO[0]} -ge 4 ] && shopt -s autocd

######################################## GIT ########################################
alias gstatus='git status -sb'
alias glog='git log --oneline'
alias glast='git log -1 HEAD --stat'
alias gdiff='git diff'

alias gremote='git remote -v'
alias gbranch='git branch -va'
alias gfetchupstream='git fetch upstream'
alias gmergeupstream='git merge upstream/main'
alias gfetchorigin='git fetch origin'
alias gmergeorigin='git merge origin/main'
alias gcheckoutmain='git checkout main'

alias gpull='git pull'
alias gadd='git add'
alias gadda='git add --all'
alias gcommit='git commit -s'
alias gcommitm='git commit -sm'
alias gpush='git push'
alias gpushf='git push --force'

alias gclearcache='git rm -r --cached .'
########################################  FAST  ########################################
alias vi='vim'
alias vi.='vim .'
# alias c='/usr/bin/clear'
alias c='clear && __prompt_to_bottom_line'
alias ee='exit'
alias code.='code . && exit'
# alias tree='tree -CAhF --dirsfirst'
alias cp='cp -r'
alias rmhistory='rm ~/.bash_history'

######################################## OTHERS ########################################
# Chmod
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'
# Copy progress bar
alias cpv='rsync -ah --info=progress2'
alias mvv='rsync -ah --remove-source-files --info=progress2'
# Search command line history
alias h="history | grep --color=always"
# Search files in the current folder
# alias f="find . | grep --color=always"
# Python creation d'envorinement
alias ve='virtualenv ./.env'
alias va='source ./.env/bin/activate || source ./env/bin/activate'
alias vave='virtualenv ./.env && source ./.env/bin/activate'
alias da='deactivate'

###########################################################################################
######################################## FUNCTIONS ########################################
###########################################################################################
#rajoute la fonction extract qui unzip tout
extract() {
  if [ -f "$1" ]; then
    case "$1" in
    *.tar.bz2) tar xvjf "$1" ;;
    *.tar.gz) tar xvzf "$1" ;;
    *.tgz) tar xvzf "$1" ;;
    *.tar.xz) tar xvJf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xvf "$1" ;;
    *.tbz2) tar xvjf "$1" ;;
    *.tgz) tar xvzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *.xz) unxz "$1" ;;
    *.exe) cabextract "$1" ;;
    *) echo "'$1': unrecognized file compression" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# convert pdf to png
pdf2png() {
  convert -density 300 "$1" -quality 100 -background white -alpha off "$2"/"${1%.*}.png"  
# -alpha remove  -colorspace RGB
#convert -density 300 3_treepred.pdf -quality 100 -background white -alpha off ./tmp/test.png
}

# Searches for text in all files in the current folder
ftext() {
  # -i case-insensitive
  # -I ignore binary files
  # -H causes filename to be printed
  # -r recursive search
  # -n causes line number to be printed
  # optional: -F treat search term as a literal, not a regular expression
  # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
  grep -iIHrn --color=always "$1" . | less -r
}

ffile() {
  find . | grep --color=always "$1"  
}


calc() {
  printf "%s\n" "$*" | bc
}

get_max_files() {
    du -a . | sort -n -r | head -n 20
}

jupyter_notebook_clear_output() {
    jupyter nbconvert --clear-output --inplace "$1"
}

__prompt_to_bottom_line() {
  tput cup $LINES
}

#######################################    My    #######################################  
# ==================Useless=================
alias coc_java_clear='rm -rf ~/.config/coc/extensions/coc-java-data/*'
alias gcollect="find ~ -xdev \( -type f \( -name .DS_Store -o -name .directory -o -name ._.DS_Store -o -name logfile.wget -o -name core -o -name Thumbs.db -o -name \*.bck -o -name .\*.bck -o -iname .\*.bak -o -name .\*~ -o -name \*.o -o -name \*.ilg -o -name \*.nav -o -name \*.snm -o -name \*.vrb -o -name \*.log -o -name \*.blg -o -name \*.bcf -o -name \*-blx.bib -o -name \*.run.xml -o -name \*.synctex.gz -o -name \*.aux -o -name a.out -o -name DEADJOE -o -name \*~ -o -iname \*.bak -o -name \*.crashdump -o -name erl_crash.dump -o -name \*.fls -o -name \*.fdb_latexmk -o -name %tmp%\* \) \) -exec rm -fv {} \;"
# ==================Jupyter=================
alias to_py='jupytext --set-formats ipynb,py:percent'

# ==================ble==================
alias ble='source ~/ble.sh/out/ble.sh'

# ==================rust==================
. "$HOME/.cargo/env"

# ==================dart/flutter==================
export PATH="$PATH:/home/federicobruzzoneplasma/flutterdev/flutter/bin"
export PATH="$PATH:/usr/lib/dart/bin"

# ==================java==================
export PATH="$PATH:/home/federicobruzzoneplasma/aspectj1.9/bin"
export CLASSPATH=".:/home/federicobruzzoneplasma/aspectj1.9/lib/aspectjrt.jar"
export CLASSPATH="$CLASSPATH:/usr/share/java/javassist.jar"

alias javaformat="java -jar /home/federicobruzzoneplasma/Documents/master-courses/advanced-programming-techniques/google-java-format-1.15.0-all-deps.jar -r"
alias javaformatall="java -jar /home/federicobruzzoneplasma/Documents/master-courses/advanced-programming-techniques/google-java-format-1.15.0-all-deps.jar -r *.java"

# ==================python==================
export ANTLR4_JAR="/home/federicobruzzoneplasma/Documents/master-courses/linguaggi-e-traduttori/lecture/jars/antlr-4.12.0-complete.jar"

# ==================STM32===========
alias stm32cubeide='/opt/st/stm32cubeide_1.11.2/stm32cubeide &'
STM32_Programmer_CLI() {
    /opt/st/stm32cubeide_1.11.2/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.0.500.202209151145/tools/bin/STM32_Programmer_CLI -c port=swd -w "$1" -rst
}
# alias STM32_Programmer_CLI="/opt/st/stm32cubeide_1.11.2/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.0.500.202209151145/tools/bin/STM32_Programmer_CLI -c port=swd -w " # -rst
alias STM32_Generate_Compile_Commands='bear -- make -j8 all -C ./Debug/'
export PATH="$PATH:/opt/st/stm32cubeide_1.11.2/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.10.3-2021.10.linux64_1.0.100.202210260954/tools/bin" # /arm-none-eabi-gcc"


# ==================xrandr===========
alias start_second_monitor_right='xrandr --output HDMI-1-0 --auto --right-of eDP-1'
alias start_second_monitor_left='xrandr --output HDMI-1-0 --auto --left-of eDP-1'
alias start_second_monitor_above='xrandr --output HDMI-1-0 --auto --above eDP-1'
alias start_second_monitor_below='xrandr --output HDMI-1-0 --auto --below eDP-1'

# function to add 1 the brightness with xrandr
brightness_p1() {
    xrandr --output eDP-1 --brightness $(echo "$(xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' ') + 0.1" | bc)
}

brightness_m1() {
    xrandr --output eDP-1 --brightness $(echo "$(xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' ') - 0.1" | bc)
}

# ==================xdg===========
open_pdf() { 
    nohup xdg-open "$1".pdf >/dev/null 2>&1 & 
}

# ==================upower===========
alias show_battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1'

# ==================latex===========
export BIBINPUTS=${HOME}/Documents/adapt-lab/bibs:.
l4p() {  # it assumes to have $BIBINPUTS set and with the dir to look into as the first one
  BIB_DIR=${BIBINPUTS%%:*}
  grep -rin"$2" -ie "$1" "$BIB_DIR"/*.bib
}
vimbib() { # it assumes to have $BIBINPUTS set and with the dir to look into as the first one
  BIB_DIR=${BIBINPUTS%%:*}
  # local bibs=()
  # for bib in "$@"
  # do
  #    bibs+=($BIB_DIR/"$bib"".bib")
  # done
  local bibs=($@)
  bibs=("${bibs[@]/%/.bib}")
  bibs=( "${bibs[@]/#/$BIB_DIR/}" )
  echo "${bibs[@]}"

  vim -p "${bibs[@]}"
}
alias clearlatex='rm -rf *.aux *.log *.out *.toc *.bbl *.blg *.synctex.gz *.fdb_latexmk *.fls *.lot *.lof *.gz'

# ==================starship===========
export STARSHIP_CONFIG=~/.config/starship.toml
HISTSIZE=1000
PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
eval "$(starship init bash)"

######################################################################

__prompt_to_bottom_line

# neofetch

ble





# ==================notes==================
#
# NERD FONT FOLDER
# /usr/local/share/fonts/
# fc-cache -fv

# add-apt-repository
# ppa:cwchien/gradle installed from ppa

# debian.sur5r.net/i3
# i3

# apt-cache policy
# sudo add-apt-repository --remove "https://zotero.retorque.re/file/apt-package-archive"


