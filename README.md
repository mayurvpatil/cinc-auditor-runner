# SurverSpec Runner

- Basic code to execute server spec sample code for linux and windows machines.

# Windows

 - Run `windowsInitScript.sh` on windows server to open winrm ports
 - Expose following environment variables before execution executions


```bash
SPEC_OS=linux/windows
SPEC_PASS=Server password
SPEC_PORT=Server connection port
SPEC_HOST_NAME=Server IP 
SPEC_USER=Server Username
```
 - Execute  `sh run.sh`


### ToDos

- [x] Implementaion of inspec sample code for linux 
- [ ] Integrate linux call in run.sh 
- [ ] Fix inspec profile
- [ ] Add support for cinc-auditor in run.sh
- [ ] Add support for SPEC_TOOL, to run code using inspc or cinc-auditor
- [ ] Integrate inspec and cinc-auditor code through rub.sh


