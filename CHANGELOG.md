# Change Log
All notable changes to this project will be documented in this file.
 
The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added
 - check_scripts/check_mongodb.sh

### Fixed

- check_scripts/check_failed_services. Fixed service name parsing previously overwritten by new changes

## [1.0.5]

### Changed

- check_scripts/check_apache2 changed progname, while do loop, functions val_wcdiff_req, get_status, get_vals

- check_scripts/check_failed_services added comments to process line args, changed process failed processes

- check_scripts/check_mysql_connections chenged critical and warning process

- check_scripts/check_nginx_errors changed count 502 and 504 errors

- check_scripts/check_proxmox_backup changed job error, critical, warning process

- install.sh added new_major and old_major to ver_it, added logging, commented checks[$cid,pid]

### Added

- check_scripts/check_mongodb

- check_scripts/check_mysql_replication

- check_scripts/get_backupstatus

- check_scripts/pidstat.sh

- update.sh

### Removed

- check_scripts/check_failed_services.bash 

- check_scripts/check_mysql_replication.bash

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
