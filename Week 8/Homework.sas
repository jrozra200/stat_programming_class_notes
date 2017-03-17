/* 	
	JACOB ROZRAN
	SAS HOMEWORK 1
	3/20/2017 
*/

/* OPTIONS TO REFRESH OUTPUT ON EACH RUN */

ods html close; ods html;

/* READ IN THE DATA */

DATA time1;
	INFILE '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 8\HW1 Time 1.txt' DLM = ', ' FIRSTOBS = 2;
	INPUT ID $ Time1;
run; 

DATA time2;
	INFILE '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 8\HW1 Time 2.txt' DLM = ' ' FIRSTOBS = 2;
	INPUT ID $ Time2;
run; 

DATA gender;
	INFILE '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 8\HW1 Gender.txt' DLM = '09'x FIRSTOBS = 2;
	INPUT ID $ Gender;
run;

PROC PRINT DATA = time1;
	TITLE1 "RAW DATA, TIME 1";
run;

PROC PRINT DATA = time2;
	TITLE1 "RAW DATA, TIME 2";
run;

PROC PRINT DATA = Gender;
	TITLE1 "RAW DATA, GENDER";
run;

/* PART 1 */

PROC SORT DATA = time1;
	BY ID;
run;

PROC SORT DATA = time2;
	BY ID;
run;

DATA time_merge;
	MERGE time1 time2; 
	BY ID;
run;

PROC PRINT DATA = time_merge;
	TITLE1 "PART ONE: MERGED TIME DATA";
run;

/* PART 2 */

PROC SORT DATA = gender;
	BY ID;
run;

DATA gender_merge;
	MERGE time_merge gender;
	BY ID;
run;

PROC PRINT DATA = gender_merge;
	TITLE1 "PART TWO: MERGED GENDER DATA";
run;

/* PART 3 */

PROC IMPORT 
	OUT = ext_data
	DATAFILE = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 8\HW1 Additional Data.xlsx' 
	DBMS = XLSX REPLACE; 
	SHEET = 'Sheet2';
run;

DATA ext_data1;
	SET ext_data;
	Gender1 = Gender * 1;
run;

DATA ext_data2;
	SET ext_data1;
	DROP Gender;
run;

DATA ext_data3 (RENAME = (Gender1=Gender) KEEP = ID Time1 Time2 Gender1);
	SET ext_data2;
run;

DATA add_data;
	SET gender_merge ext_data3;
run;

PROC PRINT DATA = add_data;
	TITLE1 "PART THREE: ADDED ADDITIONAL DATA";
run;

/* PART 4 */

PROC FORMAT;
	value malefemf 0 = 'Male' 1 = 'Female';
run;

DATA add_data_mf;
	SET add_data;
	FORMAT Gender malefemf.;
	LABEL ID = "Patient ID";
run;

PROC PRINT DATA = add_data_mf;
	TITLE1 "PART FOUR: CHANGED FORMAT AND LABEL";
run;

/* PART 5 */

DATA add_data_mf_v2;
	SET add_data;
	FORMAT Gender malefemf.;
	inc_aware = Time2 - Time1;
run;

PROC PRINT DATA = add_data_mf_v2;
	TITLE1 "PART FIVE: ADDED THE ADDITIONAL DATA FIELD";
run;

PROC MEANS DATA = add_data_mf_v2;
	TITLE "PART FIVE: PROC MEANS FOR ALL VALUES";
	VAR inc_aware;
run;

PROC MEANS DATA = add_data_mf_v2;
	TITLE "PART FIVE: PROC MEANS SPLIT BY GENDER";
	VAR inc_aware;
	CLASS Gender;
run;

/* PART 6 */

PROC TTEST DATA = add_data_mf_v2;
	TITLE "PART SIX: T TEST COMPARING GENDER";
	VAR inc_aware;
	CLASS Gender;
run;

PROC UNIVARIATE DATA = add_data_mf_v2;
	TITLE "PART SIX: HISTOGRAM OF ALL DATA";
	VAR inc_aware;
	HISTOGRAM;
run;

/* 
H0: Mu(men) = Mu(women)
Ha: Mu(men) != Mu(women)

There appears to be no differnce in 
the means in increase of health awareness 
between men and women. I have some concerns 
about normality in the data. 

As 0.6270 is not less than 0.05, we fail to 
reject the null hypothesis.

We do not have enough evidence at the 0.05-
level to reject the null hypothesis that the 
mean increase in health awareness is the same
for men and women.
*/
