create or replace FUNCTION         FN_CHK_AUTHEN
(
  in_username IN VARCHAR2 
) RETURN VARCHAR2 AS 

password_auth varchar2(100);
password_chk varchar2(100);

flag varchar2(64);


--TMP_CHECK_AUTHEN
BEGIN

    if in_username is null then
        flag := '-';

    -- elsif substr(NASPORTID,0,3)  = 'OX_' then 
    -- select SUBSTR(SUBSTR(NASPORTID,INSTR(NASPORTID, ':')),INSTR(SUBSTR(NASPORTID,INSTR(NASPORTID, ':')), '/')+1) into t_port_group from dual;
  
    else
        --chk and return flag 
        select md5(PASSWORD) into password_auth from TT_MIMS.TMP_CHECK_AUTHEN 
        where USERNAME = replace(in_username,'=2B','+');
        
        select VALUE into password_chk from tt_radius.tbl_usercheck
        where user_id IN (
        select id from tt_radius.tbl_user
        where username = replace(in_username,'=2B','+')
        and ATTRIBUTE = 'Password'
        );
        
         if password_auth = password_chk  then
        --     --select SUBSTR(NASPORTID, 1, INSTR(NASPORTID, ' ') - 1) || 
        --     --SUBSTR(SUBSTR(substr(NASPORTID,instr(NASPORTID,' ')),5,length(substr(NASPORTID,instr(NASPORTID,' ')))) ,1, INSTR(SUBSTR(substr(NASPORTID,instr(NASPORTID,' ')),5,length(substr(NASPORTID,instr(NASPORTID,' ')))) , ':') - 1) into t_port_group from dual;
            flag := 'Y';
             
        else 
            flag := 'N';
         end if;
        
    end if;  
        
    RETURN flag;
    
END FN_CHK_AUTHEN;
