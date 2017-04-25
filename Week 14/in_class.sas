/* 
JACOB ROZRAN
WEEK 14 
IN-CLASS WORK
*/

/* PROBLEM 1 */
/* PART A */
ods html close; ods html;

PROC IMPORT 
	datafile = '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 14\HHSTUDY2.xls'
	OUT = HHStudy
	DBMS = XLS
	replace;
run;

%macro reg_pos(y, x);
	PROC REG data = HHStudy;
		MODEL &y = &x;
	run;
%mend;

%reg_pos(WT, HT)

%reg_pos(GLUCOSE, CHOL)

/* PART B */
%macro reg_key(y = WT, x = HT);
	PROC REG data = HHStudy;
		MODEL &y = &x;
	run;
%mend;

ods html close; ods html;
%reg_key()

ods html close; ods html;
%reg_key(y = WT, x = HT)

ods html close; ods html;
%reg_key(y = GLUCOSE, x = CHOL)

/* PART 2 */
options MPRINT SYMBOLGEN;
ods html close; ods html;
%reg_key(y = GLUCOSE, x = CHOL)

/* PART 3 */

%macro simp_reg();
	%let inputs = POND_IDX SYS_BP GLUCOSE;
	%do i = 1 %to 3;
		PROC REG DATA = HHStudy;
			MODEL WT = %SCAN(&inputs, &i);
		run;
	%end;
%mend;

ods html close; ods html;
%simp_reg();

/* PART 4 */

%macro ttest_mac(cls_var = SMOKE, num_var = CHOL);
	PROC TTEST DATA = HHStudy;
		CLASS &cls_var;
		VAR &num_var;
	run;
%mend;

ods html close; ods html;
%ttest_mac();

/* PART 5 */

%macro ttest_ANOVA(cls_var = SMOKE, num_var = CHOL);
	PROC FREQ DATA = HHSTUDY nlevels;
		table &cls_var / out unq_lev;
	run;

	DATA _null_;
		if

	PROC TTEST DATA = HHStudy;
		CLASS &cls_var;
		VAR &num_var;
	run;
%mend;

ods html close; ods html;
%ttest_mac();

