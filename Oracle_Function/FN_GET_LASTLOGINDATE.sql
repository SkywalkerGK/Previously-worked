create or replace FUNCTION         FN_GET_LASTLOGINDATE (  
in_username IN VARCHAR2 
) RETURN date AS 

LASTLOGINDATE date;
    
BEGIN 
        select i.LASTLOGINDATE into LASTLOGINDATE from tt_radius.tbl_user_info i 
        where i.username = replace(in_username,'=2B','+');

        return LASTLOGINDATE;  
    
END;
