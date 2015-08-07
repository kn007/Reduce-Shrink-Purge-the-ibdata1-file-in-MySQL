##Reduce/Shrink/Purge the ibdata1 file in MySQL

That ibdata1 isn't shrinking is a particularly annoying feature of MySQL. The ibdata1 file cannot actually be shrunk unless you delete all databases, remove the files and reload a dump.

This project could help to reduce the ibdata1 file size.

###mysql-dump-all_db.sh

**Backup all MySQL databases except some databases**

Default to except mysql, information_schema, and performance_schema.

###mysql_innodb_basic_tables.sql

**MySQL InnoDB basic tables**

These are used in MySQL 5.6, and though are not required, will show errors in the error log if InnoDB tables are accessed and these tables are not present!



##Usage

As you want to reclaim the space from ibdata1:

1.In /etc/my.cnf -> [mysqld], add "innodb_force_recovery = 4" to set InnoDB read-only. Make sure "innodb_data_file_path" had a true value.

2.Start MySQL service. Do a mysqldump of all databases except the mysql, information_schema, and performance_schema databases.(Using mysql-dump-all_db.sh to do it)

3.Drop all databases except the above 3 databases.

4.Stop MySQL service. Delete ibdata1 and ib_logfile* files.

5.Delete innodb_index_stats.*、innodb_table_stats.*、slave_master_info.*、slave_relay_log_info.*、slave_worker_info.* files in mysql database folder(In MySQL 5.6 or higher, when you shutdown mysql, delete ibdata1, and start mysql back up, ibdata1 gets recreated. But these 5 tables are not recreated. Even if your deleted ibdata1, there are still in /usr/local/mysql/data/mysql, so need delete these files on yourself).

6.Remove "innodb_force_recovery = 4" from /etc/my.cnf. Start MySQL service.(When you start MySQL, the ibdata1 and ib_logfile* files will be recreated)

7.Restore databases from dump(See Step 2) and restore InnoDB basic tables(using the mysql_innodb_basic_tables.sql to restore).

8.Done. Restart MySQL service again to ensure error-free results. Thank you.

##Test

Testing in MySQL 5.6.25.

##About

[kn007's blog](http://kn007.net) 
