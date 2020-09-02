
# Installation

## Ruby dependency
```bash
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install ruby2.2
sudo apt-get install ruby2.2-dev

gem environment
```
### Build-Essential Package  

build-essential is a package which contains stuff needed for building software. (make, gcc ..)
```bash
sudo apt-get install build-essential
```

#### Inspec Gem installation
```bash
sudo gem install inspec
sudo gem install inspec-bin

gem list
```

# windows

```
SPEC_OS=linux/windows
SPEC_PASS=Server password
SPEC_PORT=Server connection port
SPEC_HOST_NAME=Server IP 
SPEC_USER=Server Username
```

### Windows server prerequisite
run windowsInitScript.sh to open winrm port on windows server
