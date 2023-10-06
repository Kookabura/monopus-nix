# Change Log
All notable changes to this project will be documented in this file.
 
The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

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


