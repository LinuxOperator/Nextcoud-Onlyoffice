# Nextcoud-Onlyoffice

Follow the instructions bellow to install Nextcloud and Onlyoffice in portainer (docker).


## Notes:

Run the following command to enable SMB (you will have to run this every time nextcloud is updated):
- docker exec -it nextcloud_app apt install -y smbclient

## Instructions

### Downlaod Files:
- Download set_configuration.sh to your portainer host
- Download nginx.conf file to "/portainer/Files/Inputs/nginx/nginx.conf" on your portainer host (this location is hardcoded to the config)


### Create Stack:
1. Open Portainer and navigate to Stacks, add new stack.
2. Copy text from "portainer-template.yml" into the Web editor.
3. Change values for: (default value "ChangeMe!!!"):
- MYSQL_ROOT_PASSWORD
- MYSQL_PASSWORD

4. Make sure nginx.conf is in the correct location
5. Deploy the stack
6. Navigate to http://<portainer_ip>:8030
7. Create the admin account and set the following settings:

![image](https://user-images.githubusercontent.com/68796633/161073777-0e8f0a92-42a1-48d4-8562-16ce46bbae84.png)

8. Skip recommended plugins
9. Run "sudo sh set_configuration.sh"
10. Wait ~2min, run "sudo sh set_configuration.sh" again
