CREATE OR REPLACE PROCEDURE REGISTER_RELATIONSHIP_USER_SUBJECT(
    P_USER_ID IN USERS.ID%TYPE,
    P_SUBJECT_CODE IN SUBJECTS.CODE%TYPE
)
AS
    USER_COUNT INTEGER;
    SUBJECT_COUNT INTEGER;
    RELATIONSHIP_COUNT INTEGER;
BEGIN
    SELECT COUNT(*) INTO USER_COUNT
    FROM USERS
    WHERE ID = P_USER_ID;

    SELECT COUNT(*) INTO SUBJECT_COUNT
    FROM SUBJECTS
    WHERE CODE = P_SUBJECT_CODE;

    IF USER_COUNT > 0 AND SUBJECT_COUNT > 0 THEN
        SELECT COUNT(*) INTO RELATIONSHIP_COUNT
        FROM USERS_SUBJECTS
        WHERE USER_ID = P_USER_ID AND SUBJECT_CODE = P_SUBJECT_CODE;

        IF RELATIONSHIP_COUNT > 0 THEN
            UPDATE USERS_SUBJECTS
            SET CHECKED = 1
            WHERE USER_ID = P_USER_ID AND SUBJECT_CODE = P_SUBJECT_CODE;
        ELSE
            INSERT INTO USERS_SUBJECTS (USER_ID, SUBJECT_CODE, CHECKED)
            VALUES (P_USER_ID, P_SUBJECT_CODE, 1);
        END IF;

        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END;