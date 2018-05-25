#!/usr/bin/expect

set timeout -1
set git_password [lindex $argv 0];

# if got this error "bash: /home/frappe/install_custom_app.sh: /usr/bin/expect^M: bad interpreter: No such file or directory"
# make sure EOL is set to Unix (LF)

# app1

spawn bench get-app erpnext_shopify https://github.com/frappe/erpnext_shopify

expect "Password for*"

send "$git_password\n"

expect "$ "

# app2

spawn bench get-app <app_name> <app_repo_url>

expect "Password for*"

send "$git_password\n"

expect "$ "