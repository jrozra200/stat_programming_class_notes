/* 	
	JACOB ROZRAN
	SAS HOMEWORK 2
	3/27/2017 
*/

/* OPTIONS TO REFRESH OUTPUT ON EACH RUN */

ods html close; ods html;

/* PROBLEM 1 */

DATA time1;
	INFILE '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 8\HW1 Time 1.txt' DLM = ', ' FIRSTOBS = 2;
	INPUT ID $ Time1;
run; 

DATA time2;
	INFILE '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 8\HW1 Time 2.txt' DLM = ' ' FIRSTOBS = 2;
	INPUT ID $ Time2;
run; 


PROC SORT DATA = time1;
	BY ID;
run;

PROC SORT DATA = time2;
	BY ID;
run;

DATA time_merge;
	MERGE time1 (in = A) time2 (in = B); 
	BY ID;
	IF A AND B THEN source = "In Both Time 1 and Time 2";
	ELSE IF A THEN source = "Only in Time 1";
	ELSE source = "Only in Time 2";
run;

PROC PRINT DATA = time_merge;
	TITLE1 "PART ONE: MERGED TIME DATA";
run;

PROC FREQ DATA = time_merge;
	TABLE source;
run;

/* PROBLEM 2 */

DATA gender;
	INFILE '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 8\HW1 Gender.txt' DLM = '09'x FIRSTOBS = 2;
	INPUT ID $ Gender;
run;

PROC SORT DATA = gender;
	BY ID;
run;

DATA time_merge_v1;
	SET time_merge;
	DROP source;
run;

DATA gender_merge;
	MERGE time_merge_v1 (in = A) gender (in = B);
	BY ID;
	IF A AND B THEN source = "In Time Dataset and Gender File";
	ELSE IF A THEN source = "In Time Dataset Only";
	ELSE source = "In Gender File Only";
run;

PROC PRINT DATA = gender_merge;
	TITLE1 "PART TWO: MERGED GENDER DATA";
run;

PROC FREQ DATA = gender_merge;
	TABLE source;
run;

/* PROBLEM 3 */

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

PROC PRINT DATA = prob3;
	TITLE "PART 3: UNSORTED DATA";
	FORMAT DATE MMDDYY10.;
run;

PROC SORT DATA = prob3;
	BY ID DATE;
run;

PROC PRINT DATA = prob3;
	TITLE "PART 3: SORTED DATA";
	FORMAT DATE MMDDYY10.;
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

PROC PRINT DATA = first;
	TITLE "DATASET: first";
	FORMAT DATE MMDDYY10.;
PROC PRINT DATA = last;
	TITLE "DATASET: last";
	FORMAT DATE MMDDYY10.;
PROC PRINT DATA = afterfirst;
	TITLE "DATASET: afterfirst";
	FORMAT DATE MMDDYY10.;
PROC PRINT DATA = single;
	TITLE "DATASET: single";
	FORMAT DATE MMDDYY10.;
run;
