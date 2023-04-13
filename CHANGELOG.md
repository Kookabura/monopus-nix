# Change Log
All notable changes to this project will be documented in this file.
 
The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Changed

- check_scripts/check_apache2. Changed output.
- check_scripts/check_failed_services. Changed arguments.
- check_scripts/check_oom_killer. Added log file existance condition.

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
