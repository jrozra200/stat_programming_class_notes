DATA mydata;
	input name $ gender $ age;
	datalines;
	John 	M 	15
	Sue 	F 	12
	Mary 	F 	14
	;
run;

PROC PRINT data=mydata;
run;

/*DATA mydata;
	infile 'c:\My Documents\agedata.txt';
	input name $ gender $ age;
dlm = ',' dlm = '09'x firstobs=2*/

DATA philatemps;
	input city $ month day year high low precep snow;
	infile datalines dlim = ', ' dsd missover; 
	/*dsd will read blanks (, , ,) as " "; missover will 
	count variables that aren't even delimited*/ 
