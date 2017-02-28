DATA mydata;
	LENGTH Place $12. Subject $15. Length_of_Meeting $12.;
	INPUT Time $ With $ Place $ Subject $ Length_of_Meeting $;
	DATALINES;
	11:00	Sally	Room30		PersonnelReview	45minutes
	1:00	Jim		JimsOffice	BrakeDesign		30minutes
	3:00	Nancy	Lab			TestResults		30minutes
	;
run;

PROC PRINT data=mydata;
run;

LIBNAME statprog '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 6';
DATA statprog.mydata;
	SET mydata;
run;

PROC CONTENTS data = statprog.mydata;
run;

DATA read_Data;
	LENGTH Place $12. Subject $15. Length_of_Meeting $12.;
	INFILE '\\Client\C$\Users\jrozra200\Desktop\MAT 7500 - Statistical Programming\Week 6\prob_1.txt' DLM = ', ';
	INPUT Time $ With $ Place $ Subject $ Length_of_Meeting $;
run; 

PROC PRINT data=read_Data;
run;
