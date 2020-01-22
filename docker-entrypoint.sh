#!/bin/sh

set -e

umask u+rxw,g+rwx,o-rwx

echo "WRITING MH_AUTH_FILE_CONTENT ENV VAR TO /opt/mailhog-auth"
echo $MH_AUTH_FILE_CONTENT >> /opt/mailhog-auth

MailHog -auth-file=/opt/mailhog-auth