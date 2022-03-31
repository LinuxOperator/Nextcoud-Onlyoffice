# Nextcoud-Onlyoffice

Follow the instructions bellow to install Nextcloud and Onlyoffice in portainer (docker).

**Summary of steps:**
1. Generate SSL certs
2. Place files in Portainer
3. Start containers
4. Finishing configurations


Required file tree on your system:
```
/portainer/Files/Inputs/
 ├── certs/
 │  ├── tls.key
 │  ├── tls.crt
 ├── nginx/
 │  ├── nginx.conf
 ```

## Rapid Instructions

Want to see the Manual Instructions? [Link](https://github.com/LinuxOperator/Nextcoud-Onlyoffice/edit/main/README.md#manual-instructions)

### Run command to files:
```
curl -s https://raw.githubusercontent.com/LinuxOperator/Nextcoud-Onlyoffice/main/setup.sh | bash
```

### Create Stack:
1. Open Portainer and navigate to Stacks, add new stack.
2. Copy text from "portainer-template.yml" into the Web editor.
3. Change values for:
    - MYSQL_ROOT_PASSWORD
    - MYSQL_PASSWORD
    - _(default value "ChangeMe!!!")_
4. Deploy the stack
5. Navigate to http://<portainer_ip>:4030
6. Create the admin account and set the following settings:

![image](https://user-images.githubusercontent.com/68796633/161149500-b1857171-27f0-4be8-beef-dd0b1aa86101.png)


7. Click Cancel to skip recommended plugins


### Run command to finalize configuration:
```
curl -s https://raw.githubusercontent.com/LinuxOperator/Nextcoud-Onlyoffice/main/set_configuration.sh | bash
```
Try creating/opening a ".docx" file, if it doesn't work try running the above command again



## Common problems:

1. If you get this just change the URL back to HTTPS://

![image](https://user-images.githubusercontent.com/68796633/161149659-38050399-e7c1-44bc-81db-a34e2c19c587.png)

2. Onlyoffice isn't working (file is downloaded to computer)
   - Reload the webpage
   - Wait up to 2min after running the final script
   - Re-run the final script

3. I broke it and want to start over
   - Delete the Stack in portainer
   - Delete all volume data
```
rm -rf /portainer/Files/AppData/Config/Nextcloud/
```

4. Issues logging in on mobile app
   - Modify your config:
```
nano /portainer/Files/AppData/Config/Nextcloud/web_data/config/config.php
```
Change This:
```
  'overwrite.cli.url' => 'http://192.168.0.10:4030',
```
To This:
```
  'overwrite.cli.url' => 'https://192.168.0.10:4030',
  'overwriteprotocol' => 'https',
```



# Manual Instructions

## Self signed certs:

This configuration requires SSL certificates in order to support Onlyoffice.

### Option 1: Use the certs provided
_[Note: this is insecure and should only be used if you are using an additional proxy]_

1. Download the "tls.key" and "tls.crt" to "/portainer/Files/Inputs/certs/" 

### Option 2: Generate your own certs

 - Below are a few websites that will help you generate a self-signed SSL cert.
   - [https://getacert.com/selfsignedcert.html](https://getacert.com/selfsignedcert.html)
   - [https://en.rakko.tools/tools/46/](https://en.rakko.tools/tools/46/)

1. Name them "tls.key" and "tls.crt"
2. Place files in "/portainer/Files/Inputs/certs/" 


## Download Files:
- Download set_configuration.sh to your portainer host
- Download nginx.conf file to "/portainer/Files/Inputs/nginx/nginx.conf" on your portainer host (this location is hardcoded to the config)


## Create Stack:
1. Open Portainer and navigate to Stacks, add new stack.
2. Copy text from "portainer-template.yml" into the Web editor.
3. Change values for:
    - MYSQL_ROOT_PASSWORD
    - MYSQL_PASSWORD
    - _(default value "ChangeMe!!!")_

4. Make sure nginx.conf is in the correct location
5. Deploy the stack
6. Navigate to http://<portainer_ip>:4030
7. Create the admin account and set the following settings:

![image](https://user-images.githubusercontent.com/68796633/161149500-b1857171-27f0-4be8-beef-dd0b1aa86101.png)

8. Click Cancel to skip recommended plugins
9. Run "sudo sh set_configuration.sh"
10. Try creating/opening a ".docx" file, if it doesn't work try running the above command again





## Optional Modifications:

#### 1. If you intend to put this behind a proxy with a domain, you will need to add the domain to the trusted domains.
- In portainer you can do this by:
```
sudo nano /portainer/Files/AppData/Config/Nextcloud/web_data/config/config.php
```
- Add this:
```
    2 => 'test.yourdomain.com',
```

#### 2. If you want to use SMB you need to enable the Add-on "External Storage" and install the smbclient.
- In the portainer execute this:
```
docker exec -it $(docker ps | grep nextcloud_app | cut -d' ' -f1) apt update -y
docker exec -it $(docker ps | grep nextcloud_app | cut -d' ' -f1) apt upgrade -y
docker exec -it $(docker ps | grep nextcloud_app | cut -d' ' -f1) apt install -y smbclient
```
- Unfortunately this will not survive a docker update, you will need to run this every time you update.

