rm ../current/config.coffee
ln -s ../shared/config.coffee ../current/config.coffee
pm2 kill
nohup pm2 start ../current/app.coffee >/dev/null 2>&1 </dev/null
echo "Daemon started"
