CREATE OR REPLACE TRIGGER BASIC_AUTHENTICATION_VERIFICATION
BEFORE INSERT OR UPDATE ON USERS
FOR EACH ROW
DECLARE
    EMAIL_EXISTS INT;
BEGIN
    -- VERIFY EMAIL
    SELECT COUNT(*) INTO EMAIL_EXISTS
    FROM USERS
    WHERE EMAIL = :NEW.EMAIL;
    
    IF EMAIL_EXISTS > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email already registered. Please choose another one.');
    END IF;
    
    -- VERIFY PASSWORD
    IF LENGTH(:NEW.PASSWORD) < 8 THEN
        RAISE_APPLICATION_ERROR(-20002, 'The password must contain at least 8 characters.');
    END IF;
END;