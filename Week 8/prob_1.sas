ods html close; ods html;

/* PROBLEM 1 */
/* SECTION A */

PROC IMPORT 
	OUT = stud_data_s1 
	DATAFILE = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 8\Student Data.xlsx' 
	DBMS = XLSX REPLACE; 
	SHEET = 'Sheet1';
	

run;

PROC IMPORT 
	OUT = stud_data_s2
	DATAFILE = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 8\Student Data.xlsx' 
	DBMS = XLSX REPLACE; 
	SHEET = 'Sheet2';

run;

/* SECTION B */

PROC PRINT DATA = stud_data_s1;
	WHERE substr(Name, 1, 1) = 'S';

run;

/* SECTION C */

DATA stud_data_s2_v2;
	SET stud_data_s2;
	Name = TRIM(First_Name) || " " || TRIM(Last_Name);

run;

PROC PRINT DATA = stud_data_s2_v2;
	WHERE substr(Name, 1, 1) = 'S';

run;

PROC SORT data=stud_data_s1; 
	BY Name;

run;

PROC SORT data=stud_data_s2_v2; 
	BY Name;

run;

DATA merged_data;
	MERGE stud_data_s1 stud_data_s2_v2;
	BY Name;

run;

PROC PRINT DATA = merged_data;

run;

/* PROBLEM 2 */
/* SECTION A */

DATA merged_data_v2;
	SET merged_data;
	DROP First_Name Last_Name;
	IF UPCASE(SUBSTR(RaceEthn, 1, 1)) IN ('W', 'C') THEN RaceEthn2 = 'White      ';
	ELSE RaceEthn2 = RaceEthn;

run;

PROC PRINT DATA = merged_data_v2;

run;

/* SECTION B */

DATA white non_white;
	SET merged_data_v2;
	IF TRIM(RaceEthn2) = 'White' THEN OUTPUT white;
	ELSE OUTPUT non_white;

run;

PROC PRINT DATA = white;

run;

PROC PRINT DATA = non_white;

run;
