#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset


for env_var in SMTP_RELAY SMTP_EMAIL SMTP_PASSWORD KINDLE_EMAIL ; do
    if [ ! -n "${!env_var:-}" ] ; then
        echo "$env_var is not set"
        exit 1
    fi
done


TODAY=$(date +%y-%m-%d)
RECIPE="/rss2kindle/rss.recipe"
TMP_EBOOK_FILE="/tmp/RSS${TODAY}.mobi"


echo "===> Downloading feeds and creating ebook"
echo $RECIPE
ebook-convert $RECIPE $TMP_EBOOK_FILE

echo "===> Sending ebook to Kindle"
calibre-smtp -r $SMTP_RELAY -e SSL -u $SMTP_EMAIL -p $SMTP_PASSWORD -a $TMP_EBOOK_FILE -s $TODAY $SMTP_EMAIL $KINDLE_EMAIL ""
rm $TMP_EBOOK_FILE

echo "===> Finished"
exit 0
