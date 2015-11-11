# Init
for i in epel-release ansible; do
  sudo yum --quiet --assumeyes install $i
done
# Provisioning
ansible-playbook ./playbooks/provisioning.yml
# rbenv
for j in .rbenv:https://github.com/sstephenson/rbenv.git .rbenv/plugins/ruby-build:https://github.com/sstephenson/ruby-build.git; do
  if ! [ -d ~/${j%%:*} ]; then
    git clone ${j#*:} ~/${j%%:*}
  else
    pushd ~/${j%%:*} &&
      git pull --no-ff &&
    popd
  fi
done
  # Profile
  grep --quiet "rbenv init" ~/.bash_profile || cat ./__set_rbenv_profile.sh >> ~/.bash_profile && source ~/.bash_profile
# gem
echo "gem: --no-rdoc --no-ri" > ~/.gemrc
# Ruby
RB_VERSION="2.2.3"
__install_ruby() {
  rbenv install $RB_VERSION && rbenv global $RB_VERSION
}
# Setup
rbenv versions | grep --quiet $RB_VERSION || __install_ruby
gem list | grep --quiet bundler || gem install bundler