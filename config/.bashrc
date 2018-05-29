# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
####Start SALT MANAGED Greenplum env ####
# Source definitions for Greenplum
MASTER_DATA_DIRECTORY=/data/master
if [ -f /usr/local/gpdb/greenplum_path.sh ]; then
    source /usr/local/gpdb/greenplum_path.sh
fi
####End DO NOT EDIT !!! ###############
