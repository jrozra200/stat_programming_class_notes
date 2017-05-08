/* 
Jacob Rozran
SAS Project Code 
*/

/* READING IN THE CHILDCARE FACILITY DATA */

PROC IMPORT 
	datafile = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\SAS Project\OCDEL Child Care Providers - March 2017 Delivered.xlsx'
	OUT = CCPData
	DBMS = XLSX
	replace;
	SHEET = "REPORT";
run;

/* SUMMARIZING BY ZIP CODE */

ods html close; ods html;

PROC FREQ DATA = CCPData;
	TABLE Facility_Zip_Code / out = sum_zip_code (drop = percent);
run;

/* REMOVING MISSING VALUES */

DATA sum_zip_code1;
	SET sum_zip_code (WHERE=(Facility_Zip_Code ne ''));
run;

/* HISTOGRAM OF DATA */ 

ods html close; ods html;

PROC UNIVARIATE DATA = sum_zip_code1;
	VAR COUNT;
	HISTOGRAM;
run;

/* READING IN THE MEDIAN INCOME DATA */

PROC IMPORT 
	datafile = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\SAS Project\MedianZIP-3.xlsx'
	OUT = INCOMEData
	DBMS = XLSX
	replace;
	SHEET = "nation";
run;

/* SORT THE DATA IN PREPARATION FOR MERGING */

PROC SORT DATA = sum_zip_code1;
	BY Facility_Zip_Code;
run;

/* CHANGE THE NUMERIC VARIABLE TO CHARACTER IN PREPARATION FOR MERGING */

DATA INCOMEData1;
	SET INCOMEData;
	char_Zip = put(Zip, 5.);
run;

/* SORT THE DATA IN PREPARATION FOR MERGING */

PROC SORT DATA = INCOMEData1;
	BY char_Zip;
run;

/* MERGE THE DATA */

DATA merge_income;
	MERGE sum_zip_code1 (rename=(Facility_Zip_Code=char_Zip) IN = childcare) INCOMEData1 (IN = income);
	BY char_Zip;
	FROM_childcare = childcare;
	FROM_income = income;
run;

/* PRESENT THE RESULTS OF THE MERGE */

ods html close; ods html;

PROC FREQ DATA = merge_income; 
	TABLES FROM_childcare * FROM_income; 
RUN;

/* MERGE WITH THE EDUCATION DATA */

/* CREATING THE NEW VARIABLES */

DATA new_vars;
	SET merge_income (WHERE=(FROM_childcare = 1 AND FROM_income = 1));
	ccdens = COUNT / (Pop / 1000);
	incvar = Median / Mean;
	LABEL ccdens = "childcare density" incvar = "income variability";
run;

/* CREATING HISTOGRAMS OF THE NEW VARIABLES */

ods html close; ods html;

PROC UNIVARIATE DATA = new_vars;
	VAR ccdens;
	HISTOGRAM;
run;

PROC UNIVARIATE DATA = new_vars;
	VAR incvar;
	HISTOGRAM;
run;

/* INVESTIGATING THE RELATIONSHIPS */

/* What is the relationship between mean and median household income? */

ods html close; ods html;

PROC GPLOT DATA = new_vars;
	PLOT Mean * Median;
run;

ods html close; ods html;

PROC GPLOT DATA = new_vars;
	PLOT incvar * Median;
run;

/* SINCE I DON'T HAVE EDUCATION DATA, SKIPPING PART B */

/* What is the relationship between number of childcare facilities and household
income in a specific zip code? */

ods html close; ods html;

PROC GPLOT DATA = new_vars;
	PLOT COUNT * Median;
run;

PROC GPLOT DATA = new_vars;
	PLOT ccdens * Median;
run;

/* Perform a multiple regression predicting childcare facilities */
/* OMITTING EDUCATION SINCE I DON'T HAVE THAT DATA */
ods html close; ods html;

PROC REG DATA = new_vars;
	MODEL COUNT = Median;
run;
