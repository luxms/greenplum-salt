# greenplum-salt

## Development branch, not yet ready for production use, but we're working on it !

### Building test images for Docker

./tasks dind build

### Create and run test containers for Docker

./tasks dind run

### Enter to the main container (with salt-master)

./tasks dind exec

#### List minion keys

mdw# salt-key -L

#### Accept minion keys

mdw# salt-key -A

#### Install GP

mdw# cd /srv
mdw# ./tasks 

### Remove test containers (mdw, sdw1, sdw2)

./tasks dind del