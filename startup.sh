# Init
for i in epel-release ansible; do
  sudo yum --quiet --assumeyes install $i
done
# Provisioning
ansible-playbook ./playbooks/provisioning.yml