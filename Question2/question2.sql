
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    salary NUMBER
);

-- Insert sample data
INSERT INTO employees VALUES (1, 'Alice', 100000);
INSERT INTO employees VALUES (2, 'Bob', 150000);
COMMIT;

-- Package 
CREATE OR REPLACE PACKAGE hr_salary_pkg AS

    -- Function to calculate RSSB tax and return net salary
    FUNCTION calc_net_salary(emp_id IN NUMBER) RETURN NUMBER;

    -- Dynamic procedure to update salary or insert employees
    PROCEDURE dynamic_operation(sql_stmt IN VARCHAR2);

END hr_salary_pkg;
/

CREATE OR REPLACE PACKAGE BODY hr_salary_pkg AS

    -- RSSB tax constant (example 5%)
    c_rssb_tax CONSTANT NUMBER := 0.05;

   
    FUNCTION calc_net_salary(emp_id IN NUMBER) RETURN NUMBER IS
        v_salary NUMBER;
        v_net_salary NUMBER;
    BEGIN
        SELECT salary INTO v_salary
        FROM employees
        WHERE emp_id = emp_id;

       
        v_net_salary := v_salary - (v_salary * c_rssb_tax);

     
        DBMS_OUTPUT.PUT_LINE('Package owner (USER): ' || USER);
        DBMS_OUTPUT.PUT_LINE('Current executor (CURRENT_USER): ' || CURRENT_USER);

        RETURN v_net_salary;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Employee not found.');
            RETURN NULL;
    END calc_net_salary;

   
    PROCEDURE dynamic_operation(sql_stmt IN VARCHAR2) IS
    BEGIN
        
        EXECUTE IMMEDIATE sql_stmt;

    
        DBMS_OUTPUT.PUT_LINE('Executed by CURRENT_USER: ' || CURRENT_USER);
    END dynamic_operation;

END hr_salary_pkg;
/

-- Calculate net salary for employee 1
DECLARE
    v_net NUMBER;
BEGIN
    v_net := hr_salary_pkg.calc_net_salary(1);
    DBMS_OUTPUT.PUT_LINE('Net Salary: ' || v_net);
END;
/

-- Use dynamic procedure to update salary
BEGIN
    hr_salary_pkg.dynamic_operation(
        'UPDATE employees SET salary = salary + 10000 WHERE emp_id = 1'
    );
END;
/

-- Verify the updated salary
SELECT * FROM employees;
