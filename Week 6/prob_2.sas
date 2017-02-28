ods html close; ods html;

options pagesize=72 linesize=52 pageno=1 nodate;

PROC FORMAT;
	value malefemf 1='Male' 2='Female';

DATA mydata2;
	LENGTH name $9.;
	FORMAT gender malefemf.;
	INPUT name $ gender age;
	LABEL age = 'Age (in Years)';
	DATALINES;
	Mahesh	2	17
	MarySue	1	16
	Emma	1	14
	Sarit	1	14
	Ronald	2	16
	Esmerelda	.	17
	;
run;

PROC PRINT;
PROC FREQ;
PROC CONTENTS;
run;
/* LABEL changes the output for PROC FREQ and PROC CONTENTS command. FORMAT changes how the data is 
presented in the PROC PRINT and PROC CONTENTS command*/
