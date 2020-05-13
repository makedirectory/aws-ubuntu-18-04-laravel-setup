#! /usr/bin/env bash

# MongoDB Variables
echo -n "What is the DB Connection String? "
read DBCONNECTION
echo -n "Would you like to use $DBCONNECTION? - Y or N: "
read DBCONNECTIONANSWER
DBCONNECTIONANSWER=`echo $DBCONNECTIONANSWER | tr "[:lower:]" "[:upper:]"`
until [ $DBCONNECTIONANSWER == 'Y' ]; do
    echo -n "What is the DB Connection String? "
    read DBCONNECTION
    echo -n "Would you like to use $DBCONNECTION? - Y or N: "
    read DBCONNECTIONANSWER
    DBCONNECTIONANSWER=`echo $DBCONNECTIONANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "DB_CONNECTION Set"

echo -n "What is the Database DSN? "
read DATABASEDSN
echo -n "Would you like to use \"$DATABASEDSN\"? - Y or N: "
read DATABASEDSNANSWER
DATABASEDSNANSWER=`echo $DATABASEDSNANSWER | tr "[:lower:]" "[:upper:]"`
until [ $DATABASEDSNANSWER == 'Y' ]; do
    echo -n "What is the Database DSN? "
    read DATABASEDSN
    echo -n "Would you like to use \"$DATABASEDSN\"? - Y or N: "
    read DATABASEDSNANSWER
    DATABASEDSNANSWER=`echo $DATABASEDSNANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "DB_DSN Set"

echo -n "What is the Database Name? "
read DATABASENAME
echo -n "Would you like to use $DATABASENAME? - Y or N: "
read DATABASENAMEANSWER
DATABASENAMEANSWER=`echo $DATABASENAMEANSWER | tr "[:lower:]" "[:upper:]"`
until [ $DATABASENAMEANSWER == 'Y' ]; do
    echo -n "What is the Database Name? "
    read DATABASENAME
    echo -n "Would you like to use $DATABASENAME? - Y or N: "
    read DATABASENAMEANSWER
    DATABASENAMEANSWER=`echo $DATABASENAMEANSWER | tr "[:lower:]" "[:upper:]"`
done
echo "DB_DATEBASE Set"
