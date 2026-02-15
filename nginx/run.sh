#!/bin/bash

source ../common/utils.sh

# Ensure short-link.conf exists (may not have been rendered from .j2 template yet)
touch parts/short-link.conf

chown nginx -R .
set_files_in_folder_readable_to_hiddify_common_group parts/short-link.conf
chmod g+w parts/short-link.conf

systemctl restart hiddify-nginx
systemctl start hiddify-nginx
