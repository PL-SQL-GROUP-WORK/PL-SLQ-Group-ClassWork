queries for that first question , Everything is working

CREATE TABLE access_violation_log (
    log_id           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username         VARCHAR2(50),
    action_type      VARCHAR2(20),
    attempted_time   TIMESTAMP,
    description      VARCHAR2(4000)
);

CREATE TABLE students (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(100)
);

CREATE OR REPLACE TRIGGER trg_enforce_access_policy
BEFORE INSERT OR UPDATE OR DELETE ON students
FOR EACH ROW
DECLARE
    v_day     NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'D')); 
    v_hour    NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    v_minute  NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
BEGIN
    
    IF v_day IN (1, 7) THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Access denied: No access allowed on Sabbath (Saturday or Sunday).'
        );
    END IF;

    -- Allowed time 08:00 - 17:00 (17:00 is allowed)
    IF (v_hour < 8) OR (v_hour > 17) OR (v_hour = 17 AND v_minute > 0) THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Access denied: Allowed time is 08:00 to 17:00, Monday–Friday.'
        );
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_log_access_violations
AFTER SERVERERROR ON DATABASE
DECLARE
    v_username VARCHAR2(50) := SYS_CONTEXT('USERENV', 'SESSION_USER');
    v_errcode  NUMBER := ORA_SERVER_ERROR(1);
BEGIN
   
    IF v_errcode IN (-20001, -20002) THEN
        INSERT INTO access_violation_log (
            username,
            action_type,
            attempted_time,
            description
        ) VALUES (
            v_username,
            'DML ATTEMPT',
            SYSTIMESTAMP,
            'Access violation detected. Error code: ' || v_errcode
        );
    END IF;
END;
/
// This are for testing 
INSERT INTO students VALUES (1, 'Normal User');

INSERT INTO students VALUES (2, 'Blocked User');

SELECT * FROM access_violation_log;