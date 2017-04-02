/*
Jacob Rozran
SAS Homework #3
4/2/2017
*/

/* PROBLEM 1 */
/* PART A */

ods html close; ods html;

DATA N10;
	DO i = 1 TO 10;
		obs = RAND("Normal", 100, 15);
		OUTPUT;
	END;
	DROP i;
run;

PROC UNIVARIATE DATA = N10;
	TITLE "10 Observations Plotted from the N(100, 15) distribution";
	PROBPLOT obs;
run;

/* PART B */

DATA N100;
	DO i = 1 TO 100;
		obs = RAND("Normal", 100, 15);
		OUTPUT;
	END;
	DROP i;
run;

PROC UNIVARIATE DATA = N100;
	TITLE "100 Observations Plotted from the N(100, 15) distribution";
	PROBPLOT obs;
run;

/* COMMENTS ON THE TWO PLOTS:

In the first plot, the data is more or less evenly scattered. 
In the second plot, there is definitely more points near the 
mean and less in the tails, as would be expected in a normal 
distribution. With more points, too, the data that falls off 
of the y=x line is far outweighed by those that do.

*/

/* PART C */

DATA L10;
	DO i = 1 TO 10;
		obs = RAND("LOGNORMAL");
		OUTPUT;
	END;
	DROP i;
run;

PROC UNIVARIATE DATA = L10;
	TITLE "10 Observations Plotted from the LOGNORMAL distribution";
	PROBPLOT obs;
run;

/* COMMENTS ON THE TWO PLOTS:

The first plot tends closer to the y=x line then the second,
which looks slightly exponential. With so little data in 
either plot, it is hard to see too many trends. 

*/

/* PART D */

DATA L100;
	DO i = 1 TO 100;
		obs = RAND("LOGNORMAL");
		OUTPUT;
	END;
	DROP i;
run;

PROC UNIVARIATE DATA = L100;
	TITLE "100 Observations Plotted from the LOGNORMAL distribution";
	PROBPLOT obs;
run;

/* COMMENTS ON THE THE PLOTS:

COMPARED TO PART B:

With so many points in both graphs, you can see the trend of
the underlying distributions. The Normal Distribution plot
tends to look like y=x, while the Lognormal distribution plot
looks more exponential. Also, both plots, as expected, have 
many more points around the 50th percentile than they do near
0 or 100.

COMPARTED TO PART C:

With more points in the Part D plot, you can start to see the 
trend towards the exponential curve much more clearly. As with 
the two Normal plots (10 and 100 points), having more points
shows the real trend and starts to hide the influence of any
points that don't follow perfectly the distribution.
*/

/* PART 2 */

/* COMMENTS ON THE PLOTS:

For the plots with only 10 points, you do notice real differences
each time you run the plot. With so few points, each point holds 
much more weight in observation.

When going up to the 100 point plots, it is hard to find real 
difference from one run to another. 
*/
