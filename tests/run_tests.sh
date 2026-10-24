mkdir -p ~/dc; echo halo > ~/dc/a.txt
bash bin/backup.sh ~/dc ~/hb; echo "T1 harap 0 dapat $?"
bash bin/backup.sh ~/nope ~/hb; echo "T2 harap 3 dapat $?"
bash bin/backup.sh; echo "T3 harap 2 dapat $?"
bash bin/backup.sh / ~/hb; echo "T4 harap 3 dapat $?"
sha256sum -c ~/hb/*.sha256
