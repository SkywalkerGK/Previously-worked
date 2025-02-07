#!/bin/bash

export _DATE=`date --date='-1day' '+%Y-%m-%d 02:30:00'`
export _DATEUPDATE=`date '+%Y-%m-%d %H:%M:%S'`

echo "------------------------------------------------------------------------------------------------------------------";
echo " ############### Start Auto insert Total Discon 12times Data to DB. Time : ` date +%D' '%H:%M:%S ` ###########";
echo "------------------------------------------------------------------------------------------------------------------";

echo "$_DATE";

mysql --default-character-set=utf8mb4 -u username -h 'xx.xx.xx.xx' total_discon  -p'password' <<EOF

INSERT INTO abnormal_discon_12times (DATEOPER,USERNAME,T_GROUP,RO,BRAS,NASIPADDRESS,TOTAL_DISCONNECT,
	NO_OF_USER_REQUEST,NO_OF_LOST_CARRIER,NO_OF_SESSION_TIMEOUT,NO_OF_ADMIN_RESET,NO_OF_PORT_ERROR,
	NO_OF_NAS_REQUEST,NO_OF_SCRIPT,NASPORTID,ONU_NUMBER,ACCOUNT_STATUS,FIRSTLOGINDATE,CPE_VENDOR,
	CPE_MODEL,FW_VERSION,RC,REGION,PROVINCE,PROVINCE_MAP,DATE_UPDATE)

SELECT DATEOPER,USERNAME,'FTTB' AS T_GROUP,RO,BRAS,NASIPADDRESS,TOTAL_DISCONNECT,NO_OF_USER_REQUEST,
    NO_OF_LOST_CARRIER,NO_OF_SESSION_TIMEOUT,NO_OF_ADMIN_RESET,NO_OF_PORT_ERROR,NO_OF_NAS_REQUEST,
    NO_OF_SCRIPT,NASPORTID,ONU_NUMBER,ACCOUNT_STATUS,FIRSTLOGINDATE,CPE_VENDOR,CPE_MODEL,FW_VERSION,
    RC,REGION,PROVINCE,NULL AS PROVINCE_MAP,'$_DATEUPDATE' AS DATE_UPDATE
FROM abnormal_discon_3bb
WHERE TOTAL_DISCONNECT > 12
   AND DATEOPER ='$_DATE'
   AND T_GROUP IN ('FTTB', 'FTTB(AIS)')
   AND USERNAME NOT IN (SELECT USERNAME FROM exclude_list WHERE FLAG_STATUS = 'Y')
   AND RO != '0'
   AND T_GROUP != ''

UNION ALL

SELECT DATEOPER,USERNAME,'FTTH' AS T_GROUP,RO,BRAS,NASIPADDRESS,TOTAL_DISCONNECT,NO_OF_USER_REQUEST,
    NO_OF_LOST_CARRIER,NO_OF_SESSION_TIMEOUT,NO_OF_ADMIN_RESET,NO_OF_PORT_ERROR,NO_OF_NAS_REQUEST,
    NO_OF_SCRIPT,NASPORTID,ONU_NUMBER,ACCOUNT_STATUS,FIRSTLOGINDATE,CPE_VENDOR,CPE_MODEL,FW_VERSION,
    RC,REGION,PROVINCE,NULL AS PROVINCE_MAP,'$_DATEUPDATE' AS DATE_UPDATE
FROM abnormal_discon_3bb
WHERE TOTAL_DISCONNECT > 12
   AND DATEOPER ='$_DATE'
   AND T_GROUP IN ('FTTH', 'FTTH(AIS)')
   AND USERNAME NOT IN (SELECT USERNAME FROM exclude_list WHERE FLAG_STATUS = 'Y')
   AND RO != '0'
   AND T_GROUP != '' ;

UPDATE abnormal_discon_12times t1
SET t1.province_map =
    CASE
        WHEN t1.province LIKE '%จ.กระบี่%' THEN 'KBI'
        WHEN t1.province LIKE '%จ.กาญจนบุรี%' THEN 'KRI'
        WHEN t1.province LIKE '%จ.กาฬสินธุ์%' THEN 'KSN'
        WHEN t1.province LIKE '%จ.กำแพงเพชร%' THEN 'KPT'
        WHEN t1.province LIKE '%จ.ขอนแก่น%' THEN 'KKN'
        WHEN t1.province LIKE '%จ.จันทบุรี%' THEN 'CTI'
        WHEN t1.province LIKE '%จ.ฉะเชิงเทรา%' THEN 'CCO'
        WHEN t1.province LIKE '%จ.ชลบุรี%' THEN 'CBI'
        WHEN t1.province LIKE '%จ.ชัยนาท%' THEN 'CNT'
        WHEN t1.province LIKE '%จ.ชัยภูมิ%' THEN 'CPM'
        WHEN t1.province LIKE '%จ.ชุมพร%' THEN 'CPN'
        WHEN t1.province LIKE '%จ.เชียงราย%' THEN 'CRI'
        WHEN t1.province LIKE '%จ.เชียงใหม่%' THEN 'CMI'
        WHEN t1.province LIKE '%จ.ตรัง%' THEN 'TRG'
        WHEN t1.province LIKE '%จ.ตราด%' THEN 'TRT'
        WHEN t1.province LIKE '%จ.ตาก%' THEN 'TAK'
        WHEN t1.province LIKE '%จ.นครนายก%' THEN 'NYK'
        WHEN t1.province LIKE '%จ.นครปฐม%' THEN 'NPT'
        WHEN t1.province LIKE '%จ.นครพนม%' THEN 'NPM'
        WHEN t1.province LIKE '%จ.นครราชสีมา%' THEN 'NMA'
        WHEN t1.province LIKE '%จ.นครศรีธรรมราช%' THEN 'NST'
        WHEN t1.province LIKE '%จ.นครสวรรค์%' THEN 'NSN'
        WHEN t1.province LIKE '%จ.นนทบุรี%' THEN 'NBI'
        WHEN t1.province LIKE '%จ.นราธิวาส%' THEN 'NWT'
        WHEN t1.province LIKE '%จ.น่าน%' THEN 'NAN'
        WHEN t1.province LIKE '%จ.บึงกาฬ%' THEN 'BKN'
        WHEN t1.province LIKE '%จ.บุรีรัมย์%' THEN 'BRM'
        WHEN t1.province LIKE '%จ.ปทุมธานี%' THEN 'PTE'
        WHEN t1.province LIKE '%จ.ประจวบคีรีขันธ์%' THEN 'PKN'
        WHEN t1.province LIKE '%จ.ปราจีนบุรี%' THEN 'PRI'
        WHEN t1.province LIKE '%จ.ปัตตานี%' THEN 'PTN'
        WHEN t1.province LIKE '%จ.พะเยา%' THEN 'PYO'
        WHEN t1.province LIKE '%จ.พระนครศรีอยุธยา%' THEN 'AYA'
        WHEN t1.province LIKE '%จ.พังงา%' THEN 'PNA'
        WHEN t1.province LIKE '%จ.พัทลุง%' THEN 'PLG'
        WHEN t1.province LIKE '%จ.พิจิตร%' THEN 'PCT'
        WHEN t1.province LIKE '%จ.พิษณุโลก%' THEN 'PLK'
        WHEN t1.province LIKE '%จ.เพชรบุรี%' THEN 'PBI'
        WHEN t1.province LIKE '%จ.เพชรบูรณ์%' THEN 'PNB'
        WHEN t1.province LIKE '%จ.แพร่%' THEN 'PRE'
        WHEN t1.province LIKE '%จ.ภูเก็ต%' THEN 'PKT'
        WHEN t1.province LIKE '%จ.มหาสารคาม%' THEN 'MKM'
        WHEN t1.province LIKE '%จ.มุกดาหาร%' THEN 'MDH'
        WHEN t1.province LIKE '%จ.แม่ฮ่องสอน%' THEN 'MSN'
        WHEN t1.province LIKE '%จ.ยโสธร%' THEN 'YST'
        WHEN t1.province LIKE '%จ.ยะลา%' THEN 'YLA'
        WHEN t1.province LIKE '%จ.ร้อยเอ็ด%' THEN 'RET'
        WHEN t1.province LIKE '%จ.ระนอง%' THEN 'RNG'
        WHEN t1.province LIKE '%จ.ระยอง%' THEN 'RYG'
        WHEN t1.province LIKE '%จ.ราชบุรี%' THEN 'RBR'
        WHEN t1.province LIKE '%จ.ลพบุรี%' THEN 'LRI'
        WHEN t1.province LIKE '%จ.ลำปาง%' THEN 'LPG'
        WHEN t1.province LIKE '%จ.ลำพูน%' THEN 'LPN'
        WHEN t1.province LIKE '%จ.เลย%' THEN 'LEI'
        WHEN t1.province LIKE '%จ.ศรีสะเกษ%' THEN 'SSK'
        WHEN t1.province LIKE '%จ.สกลนคร%' THEN 'SNK'
        WHEN t1.province LIKE '%จ.สงขลา%' THEN 'SKA'
        WHEN t1.province LIKE '%จ.สตูล%' THEN 'STN'
        WHEN t1.province LIKE '%จ.สมุทรปราการ%' THEN 'SPK'
        WHEN t1.province LIKE '%จ.สมุทรสงคราม%' THEN 'SKM'
        WHEN t1.province LIKE '%จ.สมุทรสาคร%' THEN 'SKN'
        WHEN t1.province LIKE '%จ.สระแก้ว%' THEN 'SKW'
        WHEN t1.province LIKE '%จ.สระบุรี%' THEN 'SRI'
        WHEN t1.province LIKE '%จ.สิงห์บุรี%' THEN 'SBR'
        WHEN t1.province LIKE '%จ.สุโขทัย%' THEN 'STI'
        WHEN t1.province LIKE '%จ.สุพรรณบุรี%' THEN 'SPB'
        WHEN t1.province LIKE '%จ.สุราษฎร์ธานี%' THEN 'SNI'
        WHEN t1.province LIKE '%จ.สุรินทร์%' THEN 'SRN'
        WHEN t1.province LIKE '%จ.หนองคาย%' THEN 'NKI'
        WHEN t1.province LIKE '%จ.หนองบัวลำภู%' THEN 'NBP'
        WHEN t1.province LIKE '%จ.อ่างทอง%' THEN 'ATG'
        WHEN t1.province LIKE '%จ.อำนาจเจริญ%' THEN 'ACR'
        WHEN t1.province LIKE '%จ.อุดรธานี%' THEN 'UDN'
        WHEN t1.province LIKE '%จ.อุตรดิตถ์%' THEN 'UTT'
        WHEN t1.province LIKE '%จ.อุทัยธานี%' THEN 'UTI'
        WHEN t1.province LIKE '%จ.อุบลราชธานี%' THEN 'UBN'
        WHEN t1.province LIKE '%จ.กรุงเทพมหานคร%' THEN 'BKK'
        WHEN t1.province LIKE '%สมุย%' THEN 'USM'
        WHEN t1.province LIKE '%ศรีราชา%' THEN 'SRC'
        WHEN t1.province LIKE '%พัทยา%' THEN 'PTY'
        WHEN t1.province LIKE '%พะงัน%' THEN 'PAG'
        ELSE NULL
    END
WHERE t1.DATEOPER = '$_DATE';

EOF

echo "------------------------------------------------------------------------------------------------------------------";
echo " ################ End Auto insert Total Discon 12times Data to DB :` date +%D' '%H:%M:%S ` #################";
echo "------------------------------------------------------------------------------------------------------------------";

