/* 
JACOB ROZRAN
IN CLASS EXERCISE
4/17/2017
*/

ods html close; ods html;

/* PART A */

DATA aaup;
	SET '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 13\aaup.sas7bdat';
run;

/* PART B */

TITLE "SALARY AT ALL RANKS";
PROC UNIVARIATE DATA = aaup;
	VAR Avg__Salary_All;
	HISTOGRAM;
run; 

PROC SORT DATA = aaup OUT = SORTED;
	BY DESCENDING Avg__Salary_All;
run;

TITLE "TOP 5 SCHOOLS FOR SALARY AT ALL RANKS";
PROC PRINT DATA = SORTED(OBS = 5);
	VAR College_Name -- Avg__Salary_All;
run;

TITLE "SALARY FOR FULL PROFESSORS";
PROC UNIVARIATE DATA = aaup;
	VAR FP_Salary;
	HISTOGRAM;
run; 

PROC SORT DATA = aaup OUT = SORTEDFP;
	BY DESCENDING FP_Salary;
run;

TITLE "TOP 5 SCHOOLS FOR SALARY FOR FULL PROFESSORS";
PROC PRINT DATA = SORTEDFP(OBS = 5);
	VAR College_Name -- Avg__Salary_All;
run;

TITLE "SALARY FOR ASSOCIATE PROFESSORS";
PROC UNIVARIATE DATA = aaup;
	VAR AP_Salary;
	HISTOGRAM;
run; 

PROC SORT DATA = aaup OUT = SORTEDAP;
	BY DESCENDING AP_Salary;
run;

TITLE "TOP 5 SCHOOLS FOR SALARY FOR ASSOCIATE PROFESSORS";
PROC PRINT DATA = SORTEDAP(OBS = 5);
	VAR College_Name -- Avg__Salary_All;
run;

TITLE "SALARY FOR ASSISTANT PROFESSORS";
PROC UNIVARIATE DATA = aaup;
	VAR Asst_P_Salary;
	HISTOGRAM;
run; 

PROC SORT DATA = aaup OUT = SORTEDAsstP;
	BY DESCENDING Asst_P_Salary;
run;

TITLE "TOP 5 SCHOOLS FOR SALARY FOR ASSISTANT PROFESSORS";
PROC PRINT DATA = SORTEDAsstP(OBS = 5);
	VAR College_Name -- Avg__Salary_All;
run;

/* PART C */

ods html close; ods html;
DATA aaup_w_ratio;
	SET aaup;
	ARRAY SALARY{4} FP_Salary -- Avg__Salary_All;
	ARRAY COMPENSATION{4} FP_Comp -- Avg__Comp_All;
	ARRAY comp_ratio{4} FP_comp_rat AP_comp_rat Asst_P_comp_rat Avg__comp_rat;
	DO i = 1 to 4;
		comp_ratio{i} = ROUND(((SALARY{i} / COMPENSATION{i}) * 100), 0.1);
	END;
	DROP i;
run;

TITLE "SALARY TO COMPENSATION RATIO AT ALL RANKS";
PROC UNIVARIATE DATA = aaup_w_ratio;
	VAR Avg__comp_rat;
	HISTOGRAM;
run; 

PROC SORT DATA = aaup_w_ratio OUT = SORTED;
	BY DESCENDING Avg__comp_rat;
run;

TITLE "TOP 5 SCHOOLS FOR SALARY TO COMPENSATION RATIO AT ALL RANKS";
PROC PRINT DATA = SORTED(OBS = 5);
	VAR College_Name FP_comp_rat -- Avg__comp_rat;
run;

TITLE "SALARY TO COMPENSATION RATIO FOR FULL PROFESSORS";
PROC UNIVARIATE DATA = aaup_w_ratio;
	VAR FP_comp_rat;
	HISTOGRAM;
run; 

PROC SORT DATA = aaup_w_ratio OUT = SORTEDFP;
	BY DESCENDING FP_comp_rat;
run;

TITLE "TOP 5 SCHOOLS FOR SALARY TO COMPENSATION RATIO FOR FULL PROFESSORS";
PROC PRINT DATA = SORTEDFP(OBS = 5);
	VAR College_Name FP_comp_rat -- Avg__comp_rat;
run;

TITLE "SALARY TO COMPENSATION RATIO FOR ASSOCIATE PROFESSORS";
PROC UNIVARIATE DATA = aaup_w_ratio;
	VAR AP_comp_rat;
	HISTOGRAM;
run; 

PROC SORT DATA = aaup_w_ratio OUT = SORTEDAP;
	BY DESCENDING AP_comp_rat;
run;

TITLE "TOP 5 SCHOOLS FOR SALARY TO COMPENSATION RATIO FOR ASSOCIATE PROFESSORS";
PROC PRINT DATA = SORTEDAP(OBS = 5);
	VAR College_Name FP_comp_rat -- Avg__comp_rat;
run;

TITLE "SALARY TO COMPENSATION RATIO FOR ASSISTANT PROFESSORS";
PROC UNIVARIATE DATA = aaup_w_ratio;
	VAR Asst_P_comp_rat;
	HISTOGRAM;
run; 

PROC SORT DATA = aaup_w_ratio OUT = SORTEDAsstP;
	BY DESCENDING Asst_P_comp_rat;
run;

TITLE "TOP 5 SCHOOLS FOR SALARY TO COMPENSATION RATIO FOR ASSISTANT PROFESSORS";
PROC PRINT DATA = SORTEDAsstP(OBS = 5);
	VAR College_Name FP_comp_rat -- Avg__comp_rat;
run;

/* PART D */

ods html close; ods html;

PROC GPLOT DATA = aaup_w_ratio;
	PLOT Avg__comp_rat * Avg__Salary_All;
run;

ods graphics on;
PROC CORR DATA = aaup_w_ratio plots=matrix(histogram);
	VAR FP_Salary -- Avg__Salary_All FP_comp_rat -- Avg__comp_rat;
run;
ods graphics off;

/* PART E */
ods html close; ods html;

PROC MEANS DATA = aaup MEAN NWAY;
	VAR FP_Salary -- Avg__Salary_All;
	CLASS STATE;
	OUTPUT OUT = aaup_means MEAN = FP_mean AP_mean Asst_P_mean All_mean;
run;

PROC PRINT DATA = aaup_means;
run;

/* PART F */

ods html close; ods html;
PROC MEANS DATA = aaup MEAN NWAY;
	VAR FP_Salary -- Avg__Salary_All;
	CLASS STATE;
	WEIGHT __Faculty_All;
	OUTPUT OUT = aaup_weighted_means MEAN = FP_mean_wt AP_mean_wt Asst_P_mean_wt All_mean_wt;
run;

PROC PRINT DATA = aaup_weighted_means;
run;

/* PART G */

ods html close; ods html;

PROC SORT DATA = aaup_means;
	BY STATE;
run;

PROC SORT DATA = aaup_weighted_means;
	BY STATE;
run;

DATA merged_means;
	MERGE aaup_means aaup_weighted_means;
	BY STATE;
run;

PROC PRINT DATA = merged_means;
run;

PROC GPLOT DATA = merged_means;
	PLOT All_mean * All_mean_wt;
run;

PROC CORR DATA = merged_means;
	VAR FP_mean -- All_mean_wt;
run;

/* PART H */

ods html close; ods html;

PROC IMPORT 
	OUT = gdp_data
	DATAFILE =  '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 13\GDP_data.xlsx'
	DBMS = XLSX REPLACE; 
	SHEET = 'Sheet1'; 
run;


DATA gdp_data1;
	SET gdp_data;
	State = LOWCASE(State);
	State = TRIM(State);
run;


PROC IMPORT 
	OUT = abbrev
	DATAFILE =  '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 13\GDP_data.xlsx'
	DBMS = XLSX REPLACE; 
	SHEET = 'Sheet2'; 
run;


DATA abbrev1;
	SET abbrev;
	State = LOWCASE(State);
	State = TRIM(State);
run;

PROC SORT DATA = gdp_data1;
	BY State;
run;

PROC SORT DATA = abbrev1;
	BY State;
run;

ods html close; ods html;
TITLE "GDP";
PROC PRINT DATA = gdp_data1;
	WHERE TRIM(State) = 'alabama';
run;
TITLE "Abbrev";
PROC PRINT DATA = abbrev1;
	WHERE State = 'alabama';
run;

DATA merged_states;
	MERGE gdp_data1 abbrev1;
	BY State;
run;



PROC PRINT DATA = merged_states;
run;
