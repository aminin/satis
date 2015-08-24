test -d web || mkdir web
test -e composer.phar || curl -sS https://getcomposer.org/installer | php
test -d satis || php composer.phar create-project composer/satis --stability=dev --keep-vcs
php satis/bin/satis build satis.json web/

