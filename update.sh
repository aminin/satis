test $REPO != '' || REPO=`git remote -v | grep pushh | awk '{ print $2 }'`
test $MESSAGE != '' || MESSAGE='update repo'

echo "=$REPO="
echo "-$MESSAGE-"

test -d web || (git clone $REPO -b gh-pages web)
test -e composer.phar || curl -sS https://getcomposer.org/installer | php
test -d satis || php composer.phar create-project composer/satis --stability=dev --keep-vcs
php satis/bin/satis build satis.json web/

git ci -a -m "$MESSAGE" && git push origin master

pushd web
  git ci -a -m "$MESSAGE" && git push origin gh-pages
popd
