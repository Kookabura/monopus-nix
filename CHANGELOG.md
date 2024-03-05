# Change Log
All notable changes to this project will be documented in this file.
 
The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.0.7]

- remove output help if parametr is set incorrectly in check_sec_update

- update output for check_mysql_replication

- update version info

- first realise check_hpstorage

- rename check_hpstorage to check_hpstorage_linux

- fix help for check_hpstorage_linux

- add sleep metric in check_mysql_connections

- add tmp dir

- update update.sh for create /tmp dir in monopus dir

- fix error copy tmp in update.sh

- fix erro in update.sh

- fix error update.sh ti create tmp dir

- fix error in update.sh to create tmp dir (definitely the last one)

- first realese check_mysql_queries

- add long update to check_mysql_queries

- fix semicolon in check_mysql_queries

- change output value in check_mysql_queries

- change perfdata format in check_mysql_connections

- add utilization on check_disk_io

- fix error in num long queries for check_mysql_queries

- fix utilization on debian in check_disk_io

- add 500 error in check_nginx_error

- align in file check_nginx_errors

- fix error calculate sleep more 60sec in check_mysql_connections

- fix error in calculate errors 50x for check_nginx_errors

- Removed the dependency on the speed of checking security updates in check_sec_update

- add case if packet manager in error

- fix errors in check_sec_update

- fix logical error in check_sec_update

- Total rewrite check_oom_killer

- Correction of storage of temporary files to the directory of monopos for check_apache2 and pidstat.sh

- update path to security-update.sh in check_sec_update

- update path in pidstat.sh

- update path in pidstat.sh

- fix error check_apache2

- fix error in check_apache2

- fix path in security-update.sh

- fix path check_mysql_queries

- apsolute path in check_sec_update

- absolute path tmp-file in check_mysql_queries

- absolute path to tmp-file in check_apache2

- fix log-error and format log for debian-like system

- fix logic error in check_oom_killer


## [1.0.6]

### Changed
- fix error 1 value in stat in check_apache2

- fix sys output in check_sec_update

- first release check_ssec_update

- try final fix infinity cpu load in pidstat link in check_apache2

- fix bag infinity cpu_load in check_apache2

- try catch infinity cpu load bug in apache2

- check_apache2 remove dead code and fix error

- fix error iops output

- fix error nc for check_memcached

- change name value in get_backupstatus

- fix message for get_backupstatus

- fix message in local_memory old name value return

- edit message for check_memcahed

- update version

- initial commit mass-update clients

- fix error used for local_memory

- fix used in local_memory

- fix calculate copies in get_backupstatus

- fix name vars check_memcached

- additional fix check logic version iostat in disk_io

- more fix for iostat 11 in disk_io

- replace semicolon on dot in disk_io anf fix divide by zero

- fix disk_io for iostat above 10 ver and add iops value

- local_memory change error message

- remade value output for local_memory, now new name

- first release check_memcahed

- modified version file - current 1.0.5-dev

- fix update.sh work on develop branch too

- Fix update.sh - add copy libs ssl in /lib

- Fix error check_disk_io for debian 11 system

- fix bug calculate cpu_load (time format AM,PM or not)

### Added
- capital letter in namr system in check_sec_update

- output number sec update in check_sec_update

- list err VMs

- swap in local_memory

- feature folder in parametr for get_backupstatus

- update version in cfg file in update.sh

- hostname in log for mass-update.sh

- message to mass-update.sh

- iops to check_disk_io

- comment to check_sec_update

- ubuntu support in check_sec_update

### Removed
- remove grep, now local_memory independend language

## [Unreleased]

### Added
 - check_scripts/check_mongodb.sh

### Fixed

- check_scripts/check_failed_services. Fixed service name parsing previously overwritten by new changes

## [1.0.5]

### Changed

- check_scripts/check_apache2 metrics are recalculated

- check_scripts/check_failed_services added comments to process line args, changed process failed processes

- check_scripts/check_mysql_connections chenged critical and warning process

- check_scripts/check_nginx_errors empty log for 24 hours

- check_scripts/check_proxmox_backup changed job error, critical, warning process

- install.sh added new_major and old_major to ver_it, added logging, commented checks[$cid,pid]

### Added

- check_scripts/check_mongodb

- check_scripts/check_mysql_replication

- check_scripts/get_backupstatus

- check_scripts/pidstat.sh

- update.sh

### Removed

- check_scripts/check_failed_services.bash remove duplicateed scripts

- check_scripts/check_mysql_replication.bash remove duplicated scripts

### Renamed

- check_scripts/check_http → check_scripts/check_website

## [1.0.4]

### Changed

- check_scripts/check_apache2. Changed output.
- check_scripts/check_failed_services. Changed arguments.
- check_scripts/check_oom_killer. Added log file existance condition.

### Fixed

- check_scripts/check_failed_services. Fixed service name parsing.

### Removed

- Removed old check check_scripts/check_apache
 
## [1.0.3] - 2023-04-06
 
### Added

- Check script: check_scripts/check_apache2.
- Check script: check_scripts/check_docker.py.
- Check script: check_scripts/check_oom_killer.
- Check script: check_scripts/check_tcp.
 
### Changed

- check_scripts/check_disk_io. Changed period and quantity of checks.
- check_scripts/check_failed_services. Changed the logic of the script.
- check_scripts/check_nginx_errors. Update check_nginx_errors.
 
### Fixed

- check_scripts/check_failed_services. Fixed passing through arguments of several services.

## [1.0.2] - 2023-03-13
 
## [1.0.1] - 2022-07-25
 
## [1.0.0-beta] - 2021-02-09



