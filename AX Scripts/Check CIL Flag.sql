-- List users who have 'Ececute in CIL' flag OFF.
SELECT id
             ,(CASE WHEN DEBUGINFO & 1024 = 1024 THEN 0 ELSE 1 END) as AX_CIL_flag
             ,*
FROM USERINFO
WHERE (CASE WHEN DEBUGINFO & 1024 = 1024 THEN 0 ELSE 1 END) = 0 ;--AX_CIL_flag is off
-- debuginfo field: bitwise and met 1024. 1024=cil off, 0=cil on
