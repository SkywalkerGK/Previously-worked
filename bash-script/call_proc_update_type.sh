#30 04 * * * sh /root/aod_script/update_type_reauth.sh 2>&1;

_LOGF=/root/aod_script/log/update_type_reauth.log
export _LOGF

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++">> $_LOGF
echo "Start update type tbl_reauth call script at `date +"%d-%m-%Y %H:%M:%S"` ">> $_LOGF
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++">> $_LOGF


mysql -u radiusinfo -h xx.xx.xx.xxx radiusinfo -p'password' <<EOF

call update_type();

EOF

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++">> $_LOGF
echo "End call script `date +"%d-%m-%Y %H:%M:%S"` ">> $_LOGF
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++">> $_LOGF
