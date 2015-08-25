test "$REPO" != '' || REPO=`git remote -v | grep push | awk '{ print $2 }'`
test "$MESSAGE" != '' || MESSAGE='update repo'

echo "REPO:    =$REPO="
echo "MESSAGE: -$MESSAGE-"

test -d web || (git clone $REPO -b gh-pages web)
pushd web
  git checkout gh-pages -f
  git pull
popd
test -e composer.phar || curl -sS https://getcomposer.org/installer | php
test -d satis || php composer.phar create-project composer/satis --stability=dev --keep-vcs
php satis/bin/satis build satis.json web/

if [[ "$1" == 'push' ]]; then
  git commit -a -m "$MESSAGE" && git push origin master

  pushd web
    git commit -a -m "$MESSAGE" && git push origin gh-pages
  popd
fi

