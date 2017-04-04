/* 
JACOB ROZRAN
IN CLASS PROBLEMS
*/

/* PROBLEM 1 */
ods html close; ods html;

DATA SALARY;
	DO year = 2017 to 2030;
		IF year = 2017 THEN DO;
			sal_bon = 50000;
			sal_rai = 50000;
		END;
		sal_bon = (sal_bon + 5000) * 1.02;
		sal_rai = (sal_rai * 1.02) + 5000;
		OUTPUT;
	END;
run;

PROC PRINT DATA = SALARY;
run;

/* PROBLEM 2 */
ods html close; ods html;

DATA ATT; 
	INFILE '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 11\attitudes.dat' DLM = ' ' FIRSTOBS = 2;
	INPUT ID $ person att;
	ID = DEQUOTE(ID);
run;

PROC SORT DATA = ATT;
	BY person;
run;

DATA ATT1;
	SET ATT;
	BY person;
	RETAIN total(0);
	RETAIN count(0);
	IF FIRST.person THEN DO;
		total = 0;
		count = 0;
	END;
	IF att ne . THEN DO;
		count + 1;
		total = total + att;
	END;
	lst = 0;
	average = total / count;
	IF LAST.person THEN lst = 1;
run;

DATA ATT2;
	SET ATT1;
	WHERE lst = 1;
	DROP ID att lst;
run;

PROC PRINT DATA = ATT2 NOOBS;
run;

/* PROBLEM 3 */

ods html close; ods html;

PROC IMPORT 
	OUT = temp_dat
	DATAFILE = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\r_proj\Philadelphia Temperatures - ALL.xlsx'
	DBMS =  XLSX REPLACE;
	SHEET = 'Sheet1';
	
run;

DATA temp_dat1;
	SET temp_dat;
	ARRAY miss999{4} High -- Snow;
	DO k = 1 TO 4;
		IF miss999{k} = -999 THEN miss999{k} = .;
	END;
	DROP k;
run;

