export _DATE=`date --date='-1day' '+%Y-%m-%d 02:30:00'`
export _DATEUPDATE=`date '+%Y-%m-%d %H:%M:%S'`

echo "------------------------------------------------------------------------------------------------------------------";
echo " ############### Start Auto insert Total Discon 12times Data to DB. Time : ` date +%D' '%H:%M:%S ` ###########";
echo "------------------------------------------------------------------------------------------------------------------";

mysql -u rootusersuper -h 'xx.xx.xx.xx' total_discon -p'password' <<EOF

INSERT INTO abnormal_discon_12times (DATEOPER,USERNAME,T_GROUP,RO,BRAS,NASIPADDRESS,TOTAL_DISCONNECT,NO_OF_USER_REQUEST,NO_OF_LOST_CARRIER,NO_OF_SESSION_TIMEOUT,NO_OF_ADMIN_RESET,NO_OF_PORT_ERROR,NO_OF_NAS_REQUEST,NO_OF_SCRIPT,DATE_UPDATE)
SELECT DATEOPER,USERNAME,T_GROUP,RO,BRAS,NASIPADDRESS,TOTAL_DISCONNECT,NO_OF_USER_REQUEST,NO_OF_LOST_CARRIER,NO_OF_SESSION_TIMEOUT,NO_OF_ADMIN_RESET,NO_OF_PORT_ERROR,NO_OF_NAS_REQUEST,NO_OF_SCRIPT,'$_DATEUPDATE' AS DATE_UPDATE
FROM abnormal_discon
WHERE TOTAL_DISCONNECT >= 12
AND DATEOPER ='$_DATE'
ORDER BY DATEOPER,USERNAME,T_GROUP ASC;

EOF

echo "------------------------------------------------------------------------------------------------------------------";
echo " ################ End Auto insert Total Discon 12times Data to DB :` date +%D' '%H:%M:%S ` #################";
echo "------------------------------------------------------------------------------------------------------------------";
