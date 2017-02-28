ods html close; ods html;

options pagesize=72 linesize=52 pageno=1 nodate;
title 'problem 3';

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


DATA mydata3;
	INPUT name $ gender age;
	DATALINES;
Maya	1	15
Amit	2	14
	;

DATA school;
	LENGTH name $9.;
	INPUT name $ school $ @@;
	DATALINES;
Mahesh	A	Emma	A	Sarit	A	Ronald	A	Maya	A	MarySue	B	Esmerelda	B	Amit	B
;
run;

DATA students;
	SET mydata2 mydata3;
run;

PROC SORT data=students; BY name;
PROC SORT data=school; BY name;

DATA studentschool;
	MERGE students school;
	BY name;
run;

PROC PRINT data=mydata2;
PROC PRINT data=mydata3;
PROC PRINT data=school;
PROC PRINT data=students;
PROC PRINT data=studentschool;
run;
