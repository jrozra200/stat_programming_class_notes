ods html close; ods html;

/* PROBLEM 1 */

DATA prob3;
	INPUT ID $ DATE MMDDYY10. CHOL_LEV;
	CARDS;
001 10/15/2004 200
002 10/15/2004 200
003 10/15/2004 300
004 10/15/2004 275
005 10/15/2004 250
002 11/10/2004 175
002 11/10/2004 175
002 11/10/2004 175
002 11/10/2004 195
004 11/13/2004 275
003 11/14/2004 280
004 12/14/2004 275
;
run;

PROC SORT DATA = prob3;
	BY ID DATE;
run;

DATA first last afterfirst single;
	SET prob3;
	COUNT + 1;
	BY ID DATE;
	dateuser = CAT(ID, DATE);
	IF first.ID THEN 
		DO;
			COUNT = 1;
			OUTPUT first;
			firstdateuser = dateuser;
		END;
	IF last.ID THEN 
		DO;
			OUTPUT last;
			lastdateuser = dateuser;
		END;
	IF COUNT = 2 THEN OUTPUT afterfirst;
	IF firstdateuser = lastdateuser AND COUNT = 1 THEN OUTPUT single;
	DROP COUNT dateuser firstdateuser lastdateuser;
run;

ODS EXCELXP file = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 10\first.xml';

PROC PRINT DATA = first;
	TITLE "DATASET: first";
	FORMAT DATE MMDDYY10.;
run;

ODS EXCELXP CLOSE;

/* PROBLEM 2 */
/* PART A */

ods html close; ods html;

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


DATA stud_data_s2_v2;
	SET stud_data_s2;
	Name = TRIM(First_Name) || " " || TRIM(Last_Name);

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


DATA merged_data_v2;
	SET merged_data;
	DROP First_Name Last_Name;
	IF UPCASE(SUBSTR(RaceEthn, 1, 1)) IN ('W', 'C') THEN RaceEthn2 = 'White      ';
	ELSE RaceEthn2 = RaceEthn;

run;

PROC GCHART DATA = merged_data_v2;
	VBAR Eyes;
	TITLE "Vertical Bar Chart of Eye Color";
run;

PROC GCHART DATA = merged_data_v2;
	VBAR Handedness;
	TITLE "Vertical Bar Chart of Handedness";
run;

PROC GCHART DATA = merged_data_v2;
	VBAR Gender;
	TITLE "Vertical Bar Chart of Gender";
run;

PROC GCHART DATA = merged_data_v2;
	VBAR RaceEthn2;
	TITLE "Vertical Bar Chart of Race/Ethnicity";
run;

PROC GCHART DATA = merged_data_v2;
	PIE3D Eyes;
	TITLE "Pie Chart of Eye Color";
run;

PROC GCHART DATA = merged_data_v2;
	PIE3D Handedness;
	TITLE "Pie Chart of Handedness";
run;

PROC GCHART DATA = merged_data_v2;
	PIE3D Gender;
	TITLE "Pie Chart of Gender";
run;

PROC GCHART DATA = merged_data_v2;
	PIE3D RaceEthn2;
	TITLE "Pie Chart of Race/Ethnicity";
run;

/* PART B */

ods html close; ods html;

PROC IMPORT 
	OUT = stud_data_s1 
	DATAFILE = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 3\HHSTUDY2.xls'
	DBMS =  XLS REPLACE;
	SHEET = 'HHSTUDY2';
	
run;

PROC SORT DATA = stud_data_s1;
	BY SMOKE;
run;

PROC SGPLOT DATA = stud_data_s1;
	TITLE "SCATTER PLOT OF HEIGHT AND WEIGHT";
	SCATTER x = HT y = WT;
run;

PROC BOXPLOT DATA = stud_data_s1;
	TITLE "BOXPLOT OF GLUCLOSE BY SMOKING STATUS";
	PLOT GLUCOSE * SMOKE;
run;

PROC BOXPLOT DATA = stud_data_s1;
	TITLE "BOXPLOT OF CHOLESTEROL BY SMOKING STATUS";
	PLOT CHOL * SMOKE;
run;

PROC BOXPLOT DATA = stud_data_s1;
	TITLE "BOXPLOT OF SYSTOLIC BP BY SMOKING STATUS";
	PLOT SYS_BP * SMOKE;
run;

/* PROBLEM 3 */

ods html close; ods html;

PROC IMPORT 
	OUT = stud_data_s1 
	DATAFILE = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 3\HHSTUDY2.xls'
	DBMS =  XLS REPLACE;
	SHEET = 'HHSTUDY2';
	
run;

/* PART A */

DATA stud_data_s2;
	SET stud_data_s1;
	IF AGE <= 49 THEN AGE_CAT = "40s";
	ELSE IF AGE <= 59 THEN AGE_CAT = "50s";
	ELSE AGE_CAT = "60s";
run;

/* PART B */

PROC FREQ DATA = stud_data_s2;
	TABLE AGE_CAT * AGE / list;
run;

/* PART C I */

PROC TABULATE DATA = stud_data_s2;
	CLASS SMOKE PHYS_ACT;
	TABLE SMOKE, PHYS_ACT;
run;

/* PART C II */

PROC TABULATE DATA = stud_data_s2;
	CLASS AGE_CAT SMOKE PHYS_ACT;
	TABLE AGE_CAT, SMOKE, PHYS_ACT;
run;

/* PART C III */

PROC TABULATE DATA = stud_data_s2;
	CLASS SMOKE PHYS_ACT;
	VAR POND_IDX;
	TABLE SMOKE, PHYS_ACT * POND_IDX * (MEAN STDDEV);
run;

/* PART D */

PROC SORT DATA = stud_data_s2;
	BY EDUC;
run;

PROC MEANS DATA = stud_data_s2 MEAN STDDEV;
	VAR CHOL;
	BY EDUC;
	OUTPUT OUT=mean_data;
run;

PROC PRINT DATA = mean_data;
run;
