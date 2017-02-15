#!/bin/sh
#
# Setup firewall, time sync

#
# Install firewall
#
# CentOS/RHEL version 7 or 6?
# note: /etc/os-release does not exist in CentOS 6, but this works anyway
if grep -Fxq "VERSION_ID=\"7\"" /etc/os-release
then
	echo "Installing firewall for Enterprise Linux version \"7\""

	# Make sure firewalld is installed, enabled, and started
	# On Digital Ocean it is installed but not enabled/started. On centos.org
	# minimal install it is installed/enabled/started. On OTF minimal install
	# it is not even installed.
	# This should be done as soon as possible to make sure we're protected early
	yum -y install firewalld
	systemctl enable firewalld
	systemctl start firewalld

else
	echo "No install required for firewall on Enterprise Linux version \"6\""
fi


#
# Setup synchronized time
#
# Ref: http://www.cyberciti.biz/faq/howto-install-ntp-to-synchronize-server-clock/
chkconfig ntpd on # Activate service
ntpdate pool.ntp.org # Synchronize the system clock with 0.pool.ntp.org server
service ntpd start # Start service
# Optionally configure ntpd via /etc/ntp.conf
