--EXEC TT_RADIUS.PROC_INSERT_LOGAUTH('bass02@3bb', '12345');

CREATE OR REPLACE PROCEDURE TT_RADIUS.PROC_INSERT_LOGAUTH (
    p_user_name IN VARCHAR2,
    p_user_password IN VARCHAR2
) AS
BEGIN

    INSERT INTO tt_radius.TBL_USER_PWD (USERNAME, PASSWORD, AUTHENTIME)
    VALUES (p_user_name, p_user_password, SYSDATE);

    COMMIT;
END;
