ods html close; ods html;

/* PROBLEM 5 */
/* PART A */

DATA men;
	DO i = 1 TO 100;
		person = i;
		height = RAND("Normal", 70, 2.5);
		output;
	END;
	DROP i;
run;

PROC PRINT DATA = men;
run;

/* PART B */

DATA men_b;
	SET men;
	weight = -202 + (5.26 * height);
run;

PROC PRINT DATA = men_b;
run;

/* PART C */

DATA men_c;
	SET men_b;
	weight_rand = weight + RAND("Normal", 0, 27);
run;

PROC PRINT DATA = men_c;
run;

/* PART D */

PROC GPLOT DATA = men_c;
	PLOT weight_rand * height;
run;

/* PART E */

DATA men_wom;
	DO i = 1 TO 100;
		person = i;
		IF RAND("Uniform") <= 0.52 THEN 
			DO;
				sex = "MALE   "; 
				height = RAND("Normal", 70, 2.5);
			END;
		ELSE 
			DO;
				sex = "FEMALE";
				height = RAND("Normal", 65, 2.5);
			END;
		weight = -202 + (5.26 * height) + RAND("Normal", 0, 27);
		OUTPUT;
	END;
	DROP i;
run;

PROC PRINT DATA = men_wom;
run;
