#! /bin/bash

vpn_configs="/etc/openvpn/client/configs/*.ovpn"
#file=$(basename $full_path)
#dir=$(dirname $full_path)

for file in $vpn_configs;
do
path=$(dirname $file)
config_name=$(basename $file)
  
  echo "---Parsing original global IP---"
    curl ipecho.net/plain; echo  
  sleep 5
  echo "---Connecting to $config_name ---"
  echo "---Copying $config_name to OpenVPN directory---"
  touch /etc/openvpn/client.conf
  cat  $file >> /etc/openvpn/client.conf
  echo "---Starting OpenVPN with $config_name ---"
    systemctl start openvpn@client.service
    echo "---Waiting for OpenVPN to connect---"  
  sleep 10
  echo "---Parsing VPN global IP---"
    curl ipecho.net/plain; echo
  sleep 10
  echo "---Downloading test data---"
    wget -O /dev/null http://212.183.159.230/5MB.zip
  echo "---Stopping OpenVPN---"
    systemctl stop openvpn@client.service
      echo "---Waiting for OpenVPN to disconnect---" 
    sleep 5
  rm -rf /etc/openvpn/client.conf
  echo "---Re-parsing original global IP---"
    curl ipecho.net/plain; echo
  sleep 5
done;
