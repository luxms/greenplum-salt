# greenplum-salt

## Development branch, not yet ready for production use, but we're working on it !

### Building test images for Docker

./tasks dind build

### Create and run test containers for Docker

./tasks dind run

### Enter to the main container (with salt-master)

./tasks dind exec

#### Install GP in master

mdw# cd /srv
mdw# ./tasks dev init
mdw# ./tasks dev apply

#### Install GP in slaves

mdw# ./tasks dev apply sdw*

#### Initialize GP database

mdw# ./tasks cfg sshinit
mdw# ./tasks cfg gpinit

### Remove test containers (mdw, sdw1, sdw2)

./tasks dind del

## For testing

#### List minion keys

mdw# salt-key -L

#### Accept minion keys

mdw# salt-key -A

#### Any commands

mdw# ./tasks dev link
mdw# ./tasks dev test
mdw# ./tasks dev testa - async run
mdw# ./tasks dev top
mdw# ./tasks dev info
