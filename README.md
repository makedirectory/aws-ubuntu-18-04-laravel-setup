**This project is no longer actively maintained.**

# aws-ubuntu-18-04-laravel-setup

Linux NGINX MongoDB(Optional) PHP Server

##  RoadMap

### Reporting
- [x] Add Sentury Support
- [ ] Add SPLUNK Support

### Databases
- [ ] Add MySQL Support

### Software
- [ ] Make Node Optional
- [ ] Make Laravel/Composer Optional
- [ ] Make PHP Optional
- [ ] Add React Support
- [ ] Add Ruby Support (via RVM)
- [ ] Add Python Support (via virtualenv(Optional), pipenv(Optional), & pyenv)

### Server Support
- [ ] Add Apache Support

### Misc
- [ ] Ability to pre-load all variables

---

## Used to deploy and setup a Laravel application via SSH
- 1.1) Git clone the setup scripts `git clone https://github.com/makedirectory/aws-ubuntu-18-04-laravel-setup aws-ubuntu-18-04-laravel-setup` OR simply copy and paste the scripts into the terminal and save using vi or nano.
**Save these scripts in ~/aws-ubuntu-18-04-laravel-setup**
- 1.2) run `bash setup.sh`
- 1.3) Add required information
- 1.4) run `bash .provision.sh` to update the application

Feel free to remove all files except `bash .provision.sh` after the initial setup as they won't be needed again.
