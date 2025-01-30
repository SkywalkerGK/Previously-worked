#00 04 * * * sh /root/krom_script/reauth/imp_reauth.sh

_LOGF=/root/krom_script/log/reauth.log
export _LOGF

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++">> $_LOGF
echo "Start import_reauth `date +"%d-%m-%Y %H:%M:%S"` ">> $_LOGF
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++">> $_LOGF


_FILE_NAME="ex_indy.csv"
export _FILE_NAME

export _YESTERDATE=`(date --date='-1 day' '+%Y%m%d')`

export _FOLDER_NAME
_file_path="/CSV/radius_checksnr/checksnr_20230721.csv";   //ตัวแปรเวลา $yesterday
#_file_path="/CSV/radius_checksnr/checksnr_20221103.csv";  //Manual

#_file_path="/CSV/netflow/finduserbyip20120308.csv";
echo $_file_path 
#cat $_file_path
#exit

mysql -u radiusinfo -h xx.xx.xx.xxx radiusinfo -p'password' <<EOF 

LOAD DATA LOCAL INFILE '${_file_path}' IGNORE
INTO TABLE tbl_reauth
CHARACTER SET latin1 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(USERNAME,NASIPADDRESS,NASPORT,COUNT_CUST,AUTH)
SET 
    
    from_date='$_YESTERDATE',
    #from_date='2022-11-03',
    username=username,
    nasipaddress=nasipaddress,
    nasport=nasport,
    count_cust=count_cust,
    date_oper=now(),
    auth=auth;

EOF

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++">> $_LOGF
echo "End import_netflow `date +"%d-%m-%Y %H:%M:%S"` ">> $_LOGF
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++">> $_LOGF
