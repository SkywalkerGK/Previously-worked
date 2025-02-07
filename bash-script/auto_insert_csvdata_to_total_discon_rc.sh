#!/bin/bash

_file_path="/home/mapuser/project_totalautodata/csv/Discon_all_3BB_`(date "+%Y-%m-%d")`.csv";
#_file_path="/home/mapuser/project_totalautodata/csv/export_abnormal_discon_`(date "+%Y%m%d")`.csv";
#_file_path="/home/mapuser/project_totalautodata/csv/Discon_all_3BB_2024-12-01.csv";

echo "------------------------------------------------------------------------------------------------------------------";
echo " ######################## Start Auto insert csv Data to DB. Time : ` date +%D' '%H:%M:%S ` ########################";
echo "------------------------------------------------------------------------------------------------------------------";

echo ${_file_path}

mysql --default-character-set=utf8 -u username -h 'xx.xx.xx.xx' total_discon  -p'password' <<EOF

LOAD DATA LOCAL INFILE '${_file_path}'
INTO TABLE abnormal_discon_3bb
CHARACTER SET tis620
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,@22,@23,@24)
SET
        DATEOPER = (DATE_ADD(DATE_FORMAT(@1,'%Y-%m-%d' ' 02:30:00'), INTERVAL -1 DAY)),
	USERNAME = @2,
        T_GROUP = @3,
        RO = @4,
        BRAS = @5,
        NASIPADDRESS = @6,
        TOTAL_DISCONNECT = @7,
        NO_OF_USER_REQUEST = @8,
        NO_OF_LOST_CARRIER = @9,
        NO_OF_SESSION_TIMEOUT = @10,
        NO_OF_ADMIN_RESET = @11,
        NO_OF_PORT_ERROR = @12,
        NO_OF_NAS_REQUEST = @13,
        NO_OF_SCRIPT = @14,
        NASPORTID = @15,
        ONU_NUMBER = @16,
        ACCOUNT_STATUS = @17,
        FIRSTLOGINDATE = @18,
        CPE_VENDOR = @19,
        CPE_MODEL = @20,
        FW_VERSION = @21,
        RC = @22,
        REGION = @23,
	PROVINCE =@24,
        DATE_UPDATE = "`(date "+%Y-%m-%d %T")`"

EOF

echo "------------------------------------------------------------------------------------------------------------------";
echo " ######################## End Auto insert csv Data to DB. Time : ` date +%D' '%H:%M:%S ` ########################";
echo "------------------------------------------------------------------------------------------------------------------";

unset _LOGF;
