*** This program lists many forms of informats that can be used to read in and print data;
*** It also shows how to use proc format as well;
*** You can find a more complete list at http://support.sas.com/documentation/cdl/en/lrdict/64316/HTML/default/viewer.htm#a001239776.htm;

ods html close; ods html;

options pagesize=72 linesize=52 pageno=1 nodate;

title 'Informats and Formats';
data informatdata;
  length longchar $13.;
  format mdy6 mmddyy8.;
  input decimals 5.2 @7 charvar $3. @11 longchar $13. @25 mdy6 mmddyy6. @32 mdy8 mmddyy8. @41 ymd6 yymmdd6. @48 ymd8 yymmdd8. @57 dmy6 ddmmyy6. @64 dmy8 ddmmyy8.
	@73 date1 date7. @81 date2 date9. @91 yrq yyq4.;
		* I am not sure why it didn't read in properly without the @ symbols...strange!!!;
  datalines;
12345 the longerversion 022717 09/06/12 120906 12/09/06 060912 06/09/12 06SEP12 06SEP2012 12Q3
;

proc print data=informatdata;
  title2 'Playing with Informats';
  * notice that this prints it ?incorrectly?, what are those numbers???;
run;

proc print data=informatdata;
  format mdy: ymd: dmy: date: worddate20. yrq worddate20.;
  * ahhh, a much better format;
  * note the use of : as a wildcard, like a * is often used, however it can only appear at the end of variable names;
run;



*** If you have your own codes in the data, you can use PROC FORMAT to assign values to it;
proc format;
  value malefemf 1='Male' 2='Female';
  value likef 1 = 'strongly dislike' 2 = 'dislike' 3 = 'neutral' 4 = 'like' 5 = 'strongly like';
  value $likef 'a' = 'strongly dislike' 'b' = 'dislike' 'c' = 'neutral' 'd' = 'like' 'e' = 'strongly like';
  	 * $likef. is a character format if the like variable were a-e instead of 1-5;

data formatdata;
  format gender malefemf. like likef.;
  label gender='Patient Gender';
  input gender like;
  * gender: 1=male, 2=female;
  * like: 1 = strongly dislike, 2 = dislike, 3 = neutral, 4 = like, 5 = strongly like;
  datalines;
1 1
1 4
1 3
2 5
2 4
;

proc freq;
title2 'Playing with Formats now';
run;

proc print;
run;

proc contents;
title2; *This will get rid of title2;
run;



* add labels;
* add titles and rerun;
* add title2s and rerun;
* add options ps ls nodate pageno (symbolgen mprint);
* see http://support.sas.com/documentation/cdl/en/lrdict/64316/HTML/default/viewer.htm#a000309878.htm for a complete list of options;

