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

run;

/* SECTION C */

DATA stud_data_s2_v2;
	SET stud_data_s2;
	Name = TRIM(First_Name) || " " || TRIM(Last_Name);

run;

PROC PRINT DATA = stud_data_s2_v2;

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

/* PROBLEM 3 */

DATA merged_data_v3;
	MERGE stud_data_s1 (in = A) stud_data_s2_v2 (in = B);
	BY Name;
	IF A AND B THEN source = "Both Files";
	ELSE IF A THEN source = "Only A";
	ELSE source = "Only B";

run;

PROC PRINT DATA = merged_data_v3;

run;

PROC FREQ DATA = merged_data_v3;
	TABLE source / nocol nopct;

run;

/* PROBLEM 4 */
/* PART A */

PROC IMPORT 
	OUT = BMI_data
	DATAFILE = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 9\BMI Scores.xlsx' 
	DBMS = XLSX REPLACE; 
	SHEET = 'Sheet1'; 

run;

PROC SORT DATA = BMI_data;
	BY Patient Date;

run;

PROC PRINT DATA = BMI_data;

run;

/* PART B */

DATA BMI_first;
	SET BMI_data; 
	BY Patient Date;
	IF first.Patient THEN firstbmi = 1; 
	ELSE firstbmi = 0;

run;


DATA BMI_first_2;
	SET BMI_first;
	WHERE firstbmi = 1;
	DROP firstbmi Date;
	RENAME BMI = firstbmi;
run;

PROC PRINT DATA = BMI_first_2;
run;

DATA BMI_data_v2;
	MERGE BMI_data BMI_first_2;
	BY Patient;
	LENGTH delbmi $8.;
	IF firstbmi = BMI THEN delbmi = "Same";
	ELSE IF firstbmi > BMI THEN delbmi = "Increase";
	ELSE delbmi = "Decrease";
run;

PROC PRINT DATA = BMI_data_v2;
run;
