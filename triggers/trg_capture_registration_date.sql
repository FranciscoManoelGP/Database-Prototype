CREATE OR REPLACE TRIGGER CAPTURE_REGISTRATION_DATE
BEFORE INSERT ON USERS
FOR EACH ROW
BEGIN
    :NEW.REGISTRATION := SYSDATE;
END;