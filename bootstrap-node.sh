#!/bin/bash

echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.200    puppet.example.com  puppet" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.210   puppet-agent1.example.com  puppet-client1" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.240   puppet-agent2.example.com  puppet-client2" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.250   puppet-agent3.example.com  puppet-client3" | sudo tee --append /etc/hosts 2> /dev/null

# Run on VM to bootstrap Puppet 5 Master.

# Install Puppet 5 Agent
wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
sudo gpg --keyserver pgp.mit.edu --recv-key 7F438280EF8D349F
sudo dpkg -i puppet5-release-xenial.deb
sudo apt update -yq
sudo apt-get install puppet-agent -yq

# Open the FW port
sudo ufw allow 8140

# start and enable puppet
sudo systemctl start puppet
sudo systemctl enable puppet
sudo apt-get install git -yq
sudo /opt/puppetlabs/bin/puppet agent -t
exit 0
