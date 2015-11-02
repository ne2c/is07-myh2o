# Init
for i in epel-release ansible; do
  yum --quiet --assumeyes install $i
done
# Provisioning
ansible-playbook /vagrant/playbooks/provisioning.yml
# rbenv
for j in .rbenv:https://github.com/sstephenson/rbenv.git .rbenv/plugins:https://github.com/sstephenson/ruby-build.git; do
  if ! [ -d ~/${j%%:*} ]; then
    git clone ${j#*:} ~/${j%%:*}
  else
    pushd ~/${j%%:*} &&
      git pull --no-ff &&
    popd
  fi
done