CREATE SEQUENCE alphseq START WITH 65 INCREMENT BY 1 MAXVALUE 91 MINVALUE 65 CYCLE ORDER;

CREATE SEQUENCE numseq START WITH 1 INCREMENT BY 1 MAXVALUE 5 MINVALUE 1 CYCLE NOCACHE ORDER;

SELECT
    chr(alphseq.CURRVAL)
    || numseq.CURRVAL
FROM
    dual;

SELECT
    chr(alphseq.NEXTVAL)
    || numseq.NEXTVAL
FROM
    employees
WHERE
    department_id IN (
        10,
        20,
        30
    );

-- Excercise Questions