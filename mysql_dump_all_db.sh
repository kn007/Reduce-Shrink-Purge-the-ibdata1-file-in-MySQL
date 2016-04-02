#!/bin/sh

MYSQL_USER=root
MYSQL_PASS=rootpassword
MYSQL_CONN="-u${MYSQL_USER} -p${MYSQL_PASS}"

#
# Collect all database names except for
# mysql, information_schema, performance_schema and sys
#

SQL="SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT IN"
SQL="${SQL} ('mysql','information_schema','performance_schema','sys')"

DBLISTFILE=/tmp/DatabasesToDump.txt
mysql ${MYSQL_CONN} -ANe"${SQL}" > ${DBLISTFILE}

DBLIST=""
for DB in `cat ${DBLISTFILE}` ; do DBLIST="${DBLIST} ${DB}" ; done

MYSQLDUMP_OPTIONS="--routines --triggers --single-transaction"
mysqldump ${MYSQL_CONN} ${MYSQLDUMP_OPTIONS} --databases ${DBLIST} > all-dbs.sql

exit
