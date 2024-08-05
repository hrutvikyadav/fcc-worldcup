#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


VALUES=$(cat <(cat games.csv | awk -F',' '{print $3}' | grep -v winner) <(cat games.csv | awk -F',' '{print $4}' | grep -v opponent) | sort | uniq | awk "{print \"('\" \$0 \"'),\"}")
VALUEZ=$(echo $VALUES | sed s/,$//)

UNIQUE_TEAMS_QUERY=$(echo -e "INSERT INTO teams(name) VALUES$VALUEZ;")

#echo -e "$PSQL \"$UNIQUE_TEAMS_QUERY\""  | bash

echo "$($PSQL "SELECT * FROM teams;")" > /tmp/all_teams_ids

#s1='s/France/FF/g'
s1=$(echo "s/Algeria/`grep Algeria /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s2=$(echo "s/Argentina/`grep Argentina /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s3=$(echo "s/Belgium/`grep Belgium /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s4=$(echo "s/Brazil/`grep Brazil /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s5=$(echo "s/Chile/`grep Chile /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s6=$(echo "s/Colombia/`grep Colombia /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s7=$(echo "s/Costa Rica/`grep "Costa Rica" /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s8=$(echo "s#Croatia#`grep Croatia /tmp/all_teams_ids|awk -F'|' '{print $1}'`#")
s9=$(echo "s/Denmark/`grep Denmark /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s10=$(echo "s/England/`grep England /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s11=$(echo "s/France/`grep France /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s12=$(echo "s/Germany/`grep Germany /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s13=$(echo "s/Greece/`grep Greece /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s14=$(echo "s/Japan/`grep Japan /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s15=$(echo "s/Mexico/`grep Mexico /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s16=$(echo "s/Netherlands/`grep Netherlands /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s17=$(echo "s/Nigeria/`grep Nigeria /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s18=$(echo "s/Portugal/`grep Portugal /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s19=$(echo "s/Russia/`grep Russia /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s20=$(echo "s/Spain/`grep Spain /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s21=$(echo "s/Sweden/`grep Sweden /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s22=$(echo "s/Switzerland/`grep Switzerland /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s23=$(echo "s/United States/`grep "United States" /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")
s24=$(echo "s/Uruguay/`grep Uruguay /tmp/all_teams_ids|awk -F'|' '{print $1}'`/g")

games_data=$(sed -e "$s1" -e "$s2" -e "$s3" -e "$s4" -e "$s5" -e "$s6" -e "$s7" -e "$s8" -e "$s9" -e "$s10" -e "$s11" -e "$s12" -e "$s13" -e "$s14" -e "$s15" -e "$s16" -e "$s17" -e "$s18" -e "$s19" -e "$s20" -e "$s21" -e "$s22" -e "$s23" -e "$s24" games.csv | sed '1d' | awk -F',' "{ print \"(\" \$1  \",\" \"'\" \$2 \"'\" \",\" \$3 \",\" \$4 \",\" \$5 \",\" \$6 \"),\" }")
gamez_data=$(echo $games_data | sed s/,$//)

All_GAMES_QUERY=$(echo -e "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES$gamez_data;")

echo -e "$PSQL \"$All_GAMES_QUERY\""  | bash


