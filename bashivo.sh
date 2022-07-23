#!/bin/bash
PRI=35
SEC=37
THI=201
FOR=3

PRIMARY="\[\e[38;5;${PRI}m\]"
SECONDARY="\[\033[38;5;${SEC}m\]"
THIRD="\[\033[38;5;${THI}m\]"
FOURTH="\[\033[38;5;${FOR}m\]"
NC="\[\033[0m\]"

grad() {
  COUNTER=0
  COLOR=$1
  COLS=$2
  TXT=${*:3}
  MOD="$(($((${#TXT}/${COLS}))*2))"
  if [ $MOD == 0 ]
  then
    MOD=1
    
  fi
  for (( i=0; i<${#TXT}; i++ )); do  
    printf "\e[38;5;${COLOR}m${TXT:COUNTER:1}"
    COUNTER=$(expr $COUNTER + 1)
    if [ $((i%$MOD)) == 0 ]
    then 
      COLOR=$(expr $COLOR + 1)
    fi
  done
}

p() {
  TEXT=$1
  printf "$PRIMARY${TEXT}${NC}"
}
s() {
  TEXT=$1
  printf "${SECONDARY}${TEXT}${NC}"
}
t() {
  TEXT=$1
  printf "${SECONDARY}${TEXT}${NC}"
}
f() {
  TEXT=$1
  printf "${FOURTH}${TEXT}${NC}"
}

c() {
  COLOR=$1
  printf "\[\e[30;48;5;${COLOR}m\] ${NC}"
}

datetime() {
  A=$(date "+%A %d %B %Y %T")
  printf "$A"
}

export PS1="$(c $(expr $SEC - 1)) $(t '💻') $(grad $PRI 5 $USER'@'$HOSTNAME) | $(p '$(grad $PRI 6 📅 $(datetime))' )$(grad $PRI 5 ' | 🚀 DBAOnlineBash') \r\n$(c $SEC) $(t '📂') $(p '$(grad $PRI 6 $(dirs))') $(t '|') \[\033[1;36m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files \[\033[1;33m\]\$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\033[0m\]\[\033[0m\]$(f '$(git branch 2>/dev/null | grep '^*' | colrm 1 1)' ) \r\n$(c $(expr $SEC + 1))$(t ' 🐧 \$') "
