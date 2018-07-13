#!/bin/bash

# exit the script on command errors or unset variables
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# https://stackoverflow.com/a/246128/295807
readonly script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${script_dir}"

# rm -f tags.db \
#     && sqlite3 tags.db < schema.sql \
#     && sqlite3 tags.db < insert_sample_data.sql

sqlite3 tags.db < insert_sample_data.sql

sqlite3 tags.db 'SELECT * FROM item;'
