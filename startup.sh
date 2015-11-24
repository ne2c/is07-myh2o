# Init
PROXY_ADDRESS=192.168.100.1
PROXY_PORT=8080
if ping -w 5 $PROXY_ADDRESS; then
  cp --verbose /etc/yum.conf /etc/yum.conf.bak
    echo "proxy=http://$PROXY_ADDRESS:$PROXY_PORT" >> /etc/yum.conf
    enable_proxy="--extra-vars extra_http_proxy=http://$PROXY_ADDRESS:$PROXY_PORT"
fi
for i in epel-release ansible; do
  sudo yum --quiet --assumeyes install $i
done
mv --force --verbose /etc/yum.conf.bak /etc/yum.conf 2>/dev/null
# Provisioning
ansible-playbook ./playbooks/provisioning.yml $enable_proxy