create or replace FUNCTION         "FN_GET_USEROPER_ACTLOG_CHANGEPWD" (  
in_username IN VARCHAR2 
) RETURN VARCHAR2 AS 

CHANGEPWD varchar2(100);
    
BEGIN 
        select to_char(m.datop,'DD/MM/YYYY HH24:MI:SS')||' '||m.maxnetuser||' By '||m.useroper into CHANGEPWD from tt_helpdesk.useroper_actlog m where id in ( 
            select max(m2.id) from tt_helpdesk.useroper_actlog m2 where m2.maxnetuser = replace(in_username,'=2B','+')
            and m2.useraction = 'change password'); 

        return CHANGEPWD;  
    
END;
