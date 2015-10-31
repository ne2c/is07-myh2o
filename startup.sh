for i in .rbenv:https://github.com/sstephenson/rbenv.git .rbenv/plugins:https://github.com/sstephenson/ruby-build.git; do
  if ! [ -d ~/${i%%:*} ]; then
    git clone ${i#*:} ~/${i%%:*}
  else
    pushd ~/${i%%:*} &&
      git pull --no-ff &&
    popd
  fi
done