/* Ncube_PTB Study SAS program/script - cleaned version for analysis.*/

/*
Notes:

- 43years: 1975-2019.
- 1983 data is missing.
- 

*/


/* #1: listing all options, library names, and creating any formats*/
options nofmterr nolabel ps=53;title;
libname proj 'C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full';
libname backup 'C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Backup';
libname dummy 'C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full_dummy';
libname main 'C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full_main';
libname on 'C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full_on';

ods rtf file='C:\Class12_output.doc' bodytitle;

/* #2 Getting to know the datasets*/
proc contents data=on.Ncube_Birth_StudyVars_1982;run;
proc print data=proj.Ncube_Birth_StudyVars_19(obs=5);run;

proc contents data=proj.Ncube_Birth_StudyVars_200;run;
proc print data=on.Ncube_Birth_StudyVars_1982 (obs=5);
	where S_MRACE_6986 = 7;
run;



/* #3 Importing the individual 43 csv format datasets*/
%macro import_datasets;
  %let files = 	Ncube_Birth_StudyVars_1975 
					Ncube_Birth_StudyVars_1976
					Ncube_Birth_StudyVars_1977
					Ncube_Birth_StudyVars_1978
					Ncube_Birth_StudyVars_1979

					Ncube_Birth_StudyVars_1980
					Ncube_Birth_StudyVars_1981
					Ncube_Birth_StudyVars_1982
					Ncube_Birth_StudyVars_1984
					Ncube_Birth_StudyVars_1985
					Ncube_Birth_StudyVars_1986
					Ncube_Birth_StudyVars_1987
					Ncube_Birth_StudyVars_1988
					Ncube_Birth_StudyVars_1989

					Ncube_Birth_StudyVars_1990
					Ncube_Birth_StudyVars_1991
					Ncube_Birth_StudyVars_1992
					Ncube_Birth_StudyVars_1993
					Ncube_Birth_StudyVars_1994
					Ncube_Birth_StudyVars_1995
					Ncube_Birth_StudyVars_1996
					Ncube_Birth_StudyVars_1997
					Ncube_Birth_StudyVars_1998
					Ncube_Birth_StudyVars_1999

					Ncube_Birth_StudyVars_2000
					Ncube_Birth_StudyVars_2001
					Ncube_Birth_StudyVars_2002
					Ncube_Birth_StudyVars_2003
					Ncube_Birth_StudyVars_2004
					Ncube_Birth_StudyVars_2005
					Ncube_Birth_StudyVars_2006
					Ncube_Birth_StudyVars_2007
					Ncube_Birth_StudyVars_2008
					Ncube_Birth_StudyVars_2009

					Ncube_Birth_StudyVars_2010
					Ncube_Birth_StudyVars_2011
					Ncube_Birth_StudyVars_2012
					Ncube_Birth_StudyVars_2013
					Ncube_Birth_StudyVars_2014
					Ncube_Birth_StudyVars_2015
					Ncube_Birth_StudyVars_2016
					Ncube_Birth_StudyVars_2017
					Ncube_Birth_StudyVars_2018
					Ncube_Birth_StudyVars_2019;

  %do i = 1 %to %sysfunc(countw(&files));
    %let file = %scan(&files, &i);
    
    PROC IMPORT DATAFILE="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\&file..csv" 
                OUT=on.&file 
                DBMS=CSV REPLACE;
    RUN;
  %end;
%mend;

%import_datasets;


/* #4 Data Manipulation: Ensuring that S_MRACE_6986 and B_INFANT_SEX are consistently either character or numeric across all datasets.*/
	/* #4 creating backup datasets*/

%macro backup_datasets;
  %let datasets = 	Ncube_Birth_StudyVars_1975 
					Ncube_Birth_StudyVars_1976
					Ncube_Birth_StudyVars_1977
					Ncube_Birth_StudyVars_1978
					Ncube_Birth_StudyVars_1979

					Ncube_Birth_StudyVars_1980
					Ncube_Birth_StudyVars_1981
					Ncube_Birth_StudyVars_1982
					Ncube_Birth_StudyVars_1984
					Ncube_Birth_StudyVars_1985
					Ncube_Birth_StudyVars_1986
					Ncube_Birth_StudyVars_1987
					Ncube_Birth_StudyVars_1988
					Ncube_Birth_StudyVars_1989

					Ncube_Birth_StudyVars_1990
					Ncube_Birth_StudyVars_1991
					Ncube_Birth_StudyVars_1992
					Ncube_Birth_StudyVars_1993
					Ncube_Birth_StudyVars_1994
					Ncube_Birth_StudyVars_1995
					Ncube_Birth_StudyVars_1996
					Ncube_Birth_StudyVars_1997
					Ncube_Birth_StudyVars_1998
					Ncube_Birth_StudyVars_1999

					Ncube_Birth_StudyVars_2000
					Ncube_Birth_StudyVars_2001
					Ncube_Birth_StudyVars_2002
					Ncube_Birth_StudyVars_2003
					Ncube_Birth_StudyVars_2004
					Ncube_Birth_StudyVars_2005
					Ncube_Birth_StudyVars_2006
					Ncube_Birth_StudyVars_2007
					Ncube_Birth_StudyVars_2008
					Ncube_Birth_StudyVars_2009

					Ncube_Birth_StudyVars_2010
					Ncube_Birth_StudyVars_2011
					Ncube_Birth_StudyVars_2012
					Ncube_Birth_StudyVars_2013
					Ncube_Birth_StudyVars_2014
					Ncube_Birth_StudyVars_2015
					Ncube_Birth_StudyVars_2016
					Ncube_Birth_StudyVars_2017
					Ncube_Birth_StudyVars_2018
					Ncube_Birth_StudyVars_2019;

  %do i = 1 %to %sysfunc(countw(&datasets));
    %let ds = %scan(&datasets, &i);
    
    proc copy in=on out=ten;
      select &ds;
    run;
  %end;
%mend;
%backup_datasets;


/* #5 which of the 43 datasets have S_MRACE_6986 and B_INFANT_SEX defined as chracter variables*/

%macro check_variable_types;
  %let datasets = 	Ncube_Birth_StudyVars_1975 
					Ncube_Birth_StudyVars_1976
					Ncube_Birth_StudyVars_1977
					Ncube_Birth_StudyVars_1978
					Ncube_Birth_StudyVars_1979

					Ncube_Birth_StudyVars_1980
					Ncube_Birth_StudyVars_1981
					Ncube_Birth_StudyVars_1982
					Ncube_Birth_StudyVars_1984
					Ncube_Birth_StudyVars_1985
					Ncube_Birth_StudyVars_1986
					Ncube_Birth_StudyVars_1987
					Ncube_Birth_StudyVars_1988
					Ncube_Birth_StudyVars_1989

					Ncube_Birth_StudyVars_1990
					Ncube_Birth_StudyVars_1991
					Ncube_Birth_StudyVars_1992
					Ncube_Birth_StudyVars_1993
					Ncube_Birth_StudyVars_1994
					Ncube_Birth_StudyVars_1995
					Ncube_Birth_StudyVars_1996
					Ncube_Birth_StudyVars_1997
					Ncube_Birth_StudyVars_1998
					Ncube_Birth_StudyVars_1999

					Ncube_Birth_StudyVars_2000
					Ncube_Birth_StudyVars_2001
					Ncube_Birth_StudyVars_2002
					Ncube_Birth_StudyVars_2003
					Ncube_Birth_StudyVars_2004
					Ncube_Birth_StudyVars_2005
					Ncube_Birth_StudyVars_2006
					Ncube_Birth_StudyVars_2007
					Ncube_Birth_StudyVars_2008
					Ncube_Birth_StudyVars_2009

					Ncube_Birth_StudyVars_2010
					Ncube_Birth_StudyVars_2011
					Ncube_Birth_StudyVars_2012
					Ncube_Birth_StudyVars_2013
					Ncube_Birth_StudyVars_2014
					Ncube_Birth_StudyVars_2015
					Ncube_Birth_StudyVars_2016
					Ncube_Birth_StudyVars_2017
					Ncube_Birth_StudyVars_2018
					Ncube_Birth_StudyVars_2019;

  %do i = 1 %to %sysfunc(countw(&datasets));
    %let ds = %scan(&datasets, &i);
    
    proc contents data=backup.&ds out=contents(keep=name type) noprint;
    run;
    
    data _null_;
      set contents;
      if name in ('S_MRACE_6986', 'B_INFANT_SEX') and type = 2 then do;
        put 'In dataset ' "&ds" ', variable ' name ' is a character variable.';
      end;
    run;
  %end;
%mend;

%check_variable_types;

/* #6 ### convert S_MRACE_6986 to numeric.*/

%macro transform_variables;
  %let datasets = 	Ncube_Birth_StudyVars_1982 
					Ncube_Birth_StudyVars_1988
					Ncube_Birth_StudyVars_1989
					Ncube_Birth_StudyVars_1990
					Ncube_Birth_StudyVars_1992
					Ncube_Birth_StudyVars_1993
					Ncube_Birth_StudyVars_1998
					Ncube_Birth_StudyVars_2001
					Ncube_Birth_StudyVars_2004
					Ncube_Birth_StudyVars_2005

					Ncube_Birth_StudyVars_2006
					Ncube_Birth_StudyVars_2007
					Ncube_Birth_StudyVars_2008
					Ncube_Birth_StudyVars_2009
					Ncube_Birth_StudyVars_2010;

  %do i = 1 %to %sysfunc(countw(&datasets));
    %let ds = %scan(&datasets, &i);
    
    DATA dummy.&ds;
        SET dummy.&ds;
        IF vtype(S_MRACE_6986) = 'C' THEN DO;
            S_MRACE_6986_num = INPUT(S_MRACE_6986, ?best12.);
            DROP S_MRACE_6986;
            RENAME S_MRACE_6986_num = S_MRACE_6986;
        END;
    RUN;
  %end;
%mend;
%transform_variables;

/* #7 Convert S_MRACE_6986 to numeric.*/

%macro transform_dataset(dsname);

    data &dsname;
        set &dsname;
        /* Create a new numeric variable from the character variable */
        S_MRACE_6986_num = input(S_MRACE_6986, 1.);
        /* Drop the original character variable */
        drop S_MRACE_6986;
        /* Rename the new numeric variable back to the original variable name */
        rename S_MRACE_6986_num = S_MRACE_6986;
    run;

%mend;

%transform_dataset(on.Ncube_Birth_StudyVars_1982);
%transform_dataset(on.Ncube_Birth_StudyVars_1988);
%transform_dataset(on.Ncube_Birth_StudyVars_1989);
%transform_dataset(on.Ncube_Birth_StudyVars_1990);
%transform_dataset(on.Ncube_Birth_StudyVars_1992);
%transform_dataset(on.Ncube_Birth_StudyVars_1993);
%transform_dataset(on.Ncube_Birth_StudyVars_1998);
%transform_dataset(on.Ncube_Birth_StudyVars_2001);
%transform_dataset(on.Ncube_Birth_StudyVars_2004);
%transform_dataset(on.Ncube_Birth_StudyVars_2005);
%transform_dataset(on.Ncube_Birth_StudyVars_2006);
%transform_dataset(on.Ncube_Birth_StudyVars_2007);
%transform_dataset(on.Ncube_Birth_StudyVars_2008);
%transform_dataset(on.Ncube_Birth_StudyVars_2009);
%transform_dataset(on.Ncube_Birth_StudyVars_2010);

/* #8  convert B_INFANT_SEX to numeric.*/

%macro transform_variables_two;
  %let datasets = 	Ncube_Birth_StudyVars_2012 
					Ncube_Birth_StudyVars_2013
					Ncube_Birth_StudyVars_2014
					Ncube_Birth_StudyVars_2015
					Ncube_Birth_StudyVars_2016
					Ncube_Birth_StudyVars_2017
					Ncube_Birth_StudyVars_2018
					Ncube_Birth_StudyVars_2019;

  %do i = 1 %to %sysfunc(countw(&datasets));
    %let ds = %scan(&datasets, &i);
    
    DATA on.&ds;
        SET on.&ds;
        IF B_INFANT_SEX = 'M' THEN B_INFANT_SEX_num = 1;
        ELSE IF B_INFANT_SEX = 'F' THEN B_INFANT_SEX_num = 2;
        ELSE IF B_INFANT_SEX = 'U' THEN B_INFANT_SEX_num = 3;
        ELSE IF B_INFANT_SEX = '9' THEN B_INFANT_SEX_num = 9;
        ELSE B_INFANT_SEX_num = .; /* Handle other cases as needed */
        
        DROP B_INFANT_SEX;
        RENAME B_INFANT_SEX_num = B_INFANT_SEX;
    RUN;
  %end;
%mend;
%transform_variables_two;

/* #9  Transfroming race categories in year 1975 - 2010 */

%macro transform_datasets_race;
  %let datasets = 	Ncube_Birth_StudyVars_1975
                    Ncube_Birth_StudyVars_1976
					Ncube_Birth_StudyVars_1977
					Ncube_Birth_StudyVars_1978
					Ncube_Birth_StudyVars_1979

					Ncube_Birth_StudyVars_1980
					Ncube_Birth_StudyVars_1981
					Ncube_Birth_StudyVars_1982
					Ncube_Birth_StudyVars_1984
					Ncube_Birth_StudyVars_1985
					Ncube_Birth_StudyVars_1986
					Ncube_Birth_StudyVars_1987
					Ncube_Birth_StudyVars_1988
					Ncube_Birth_StudyVars_1989

					Ncube_Birth_StudyVars_1990
					Ncube_Birth_StudyVars_1991
					Ncube_Birth_StudyVars_1992
					Ncube_Birth_StudyVars_1993
					Ncube_Birth_StudyVars_1994
					Ncube_Birth_StudyVars_1995
					Ncube_Birth_StudyVars_1996
					Ncube_Birth_StudyVars_1997
					Ncube_Birth_StudyVars_1998
					Ncube_Birth_StudyVars_1999

					Ncube_Birth_StudyVars_2000
					Ncube_Birth_StudyVars_2001
					Ncube_Birth_StudyVars_2002
					Ncube_Birth_StudyVars_2003
					Ncube_Birth_StudyVars_2004
					Ncube_Birth_StudyVars_2005
					Ncube_Birth_StudyVars_2006
					Ncube_Birth_StudyVars_2007
					Ncube_Birth_StudyVars_2008
					Ncube_Birth_StudyVars_2009

					Ncube_Birth_StudyVars_2010;

  %do i = 1 %to %sysfunc(countw(&datasets));
    %let ds = %scan(&datasets, &i);

    data on.&ds;
        set on.&ds;

        /* Reassign the values for the race variable */
        if S_MRACE_6986 in (4, 5, 6, 8) then S_MRACE_6986 = 4;
		if S_MRACE_6986 = 7 then S_MRACE_6986 = 9;
    run;
  %end;
%mend;

%transform_datasets_race;

/* #10  Transforming race categories in year 2011 */

data on.Ncube_Birth_StudyVars_2011;
    set on.Ncube_Birth_StudyVars_2011;

    /* Reassign values for MRACEGROUP */
    if MRACEGROUP = "Hispanic" then MRACEGROUP_NUM = 0;
    else if MRACEGROUP = "White NH" then MRACEGROUP_NUM = 1;
    else if MRACEGROUP = "Black NH" then MRACEGROUP_NUM = 2;
    else if MRACEGROUP = "Aindian" then MRACEGROUP_NUM = 3;
    else if MRACEGROUP = "Asian/PI NH" then MRACEGROUP_NUM = 4;
    else if MRACEGROUP in ("Other NH", "Unknown") then MRACEGROUP_NUM = 9;

    /* Drop the original variable and rename the new one */
    drop MRACEGROUP;
    rename MRACEGROUP_NUM = S_MRACE_6986;
run;

/* #11  Transforming race categories 2012-2019 */

%macro transform_race(year_start=, year_end=);

%do year = &year_start %to &year_end;

    data on.Ncube_Birth_StudyVars_&year.;
        set on.Ncube_Birth_StudyVars_&year.;

        /* Reassign values for MRACEGROUP */
        if MRACEGROUP = "Hispanic" then MRACEGROUP_NUM = 0;
        else if MRACEGROUP = "White NH" then MRACEGROUP_NUM = 1;
        else if MRACEGROUP = "Black NH" then MRACEGROUP_NUM = 2;
        else if MRACEGROUP = "Aindian" then MRACEGROUP_NUM = 3;
        else if MRACEGROUP = "Asian/PI NH" then MRACEGROUP_NUM = 4;
        else if MRACEGROUP in ("Other NH", "Unknown") then MRACEGROUP_NUM = 9;

        /* Drop the original variable and rename the new one */
        drop MRACEGROUP;
        rename MRACEGROUP_NUM = S_MRACE_6986;
    run;

%end;

%mend transform_race;

%transform_race(year_start=2012, year_end=2019);

/* #12  renaming  gestational age variable in the year 2011 */
data on.Ncube_Birth_StudyVars_2011;
    set on.Ncube_Birth_StudyVars_2011 (rename=(ACALCGESTAGE=S_INFANT_GEST_CALC));
run;


/* #13  Set Merger: Vertical merger */

data on.C_merged; 
set 	on.Ncube_Birth_StudyVars_1975
		on.Ncube_Birth_StudyVars_1976
		on.Ncube_Birth_StudyVars_1977
		on.Ncube_Birth_StudyVars_1978
		on.Ncube_Birth_StudyVars_1979

		on.Ncube_Birth_StudyVars_1980
		on.Ncube_Birth_StudyVars_1981
		on.Ncube_Birth_StudyVars_1982
		on.Ncube_Birth_StudyVars_1984
		on.Ncube_Birth_StudyVars_1985
		on.Ncube_Birth_StudyVars_1986
		on.Ncube_Birth_StudyVars_1987
		on.Ncube_Birth_StudyVars_1988
		on.Ncube_Birth_StudyVars_1989

		on.Ncube_Birth_StudyVars_1990
		on.Ncube_Birth_StudyVars_1991
		on.Ncube_Birth_StudyVars_1992
		on.Ncube_Birth_StudyVars_1993
		on.Ncube_Birth_StudyVars_1994
		on.Ncube_Birth_StudyVars_1995
		on.Ncube_Birth_StudyVars_1996
		on.Ncube_Birth_StudyVars_1997
		on.Ncube_Birth_StudyVars_1998
		on.Ncube_Birth_StudyVars_1999

		on.Ncube_Birth_StudyVars_2000
		on.Ncube_Birth_StudyVars_2001
		on.Ncube_Birth_StudyVars_2002
		on.Ncube_Birth_StudyVars_2003
		on.Ncube_Birth_StudyVars_2004
		on.Ncube_Birth_StudyVars_2005
		on.Ncube_Birth_StudyVars_2006
		on.Ncube_Birth_StudyVars_2007
		on.Ncube_Birth_StudyVars_2008
		on.Ncube_Birth_StudyVars_2009

		on.Ncube_Birth_StudyVars_2010
		on.Ncube_Birth_StudyVars_2011
		on.Ncube_Birth_StudyVars_2012
		on.Ncube_Birth_StudyVars_2013
		on.Ncube_Birth_StudyVars_2014
		on.Ncube_Birth_StudyVars_2015
		on.Ncube_Birth_StudyVars_2016
		on.Ncube_Birth_StudyVars_2017
		on.Ncube_Birth_StudyVars_2018
		on.Ncube_Birth_StudyVars_2019;
run;	


/* #14  creating PTB variable */


	* Create a temporary copy to manipulate; 
data on.C_M_manipulate; 
	set on.C_merged;
run;

	* Create new columns in the dataset;
data on.C_M_manipulate; 
set on.C_M_manipulate;

	*Create PTB variable as categorical; 
if S_INFANT_GEST_CALC < '36' & S_INFANT_GEST_CALC > '20' then PTB = "Yes";
else if S_INFANT_GEST_CALC >= '36' & S_INFANT_GEST_CALC < '43' then PTB = "No";
else PTB = .; 

*Create PTB variable as numeric; 
if PTB = "Yes" then ptb_num = 1;
else if PTB = "No" then ptb_num = 0;
else ptb_num = .; 
run;

/* #15  trends analysis */

	/* Aggregate the Data: Calculating the percentage of preterm births (ptb_num=1) for each race and year.*/

proc sql;
    create table aggregated as
    select 
        year,
        S_MRACE_6986 as race,
        sum(ptb_num) as num_preterm,
        count(ptb_num) as total_births,
        (sum(ptb_num)/count(ptb_num))*100 as percent_preterm
    from on.C_M_manipulate
    group by year, S_MRACE_6986;
quit;

	/* Visualizing the Trend:  plot the time series trend using PROC SGPLOT.*/
proc sgplot data=aggregated_2;
    series x=year y=percent_preterm / group=race break;
    xaxis label="Year";
    yaxis label="Percentage of Preterm Births" grid min=0 max=20;
    title "Trend in Preterm Births by Race (1975-2019)";
    keylegend / title="Race";
run;
/* rename the race values .*/
proc format;
    value racefmt
        0 = 'Hispanic'
        1 = 'White'
        2 = 'Black'
        4 = 'Asian/Pacific'
        9 = 'Unknown';
run;
data aggregated_2;
    set aggregated;
    format race racefmt.;
run;



proc sgplot data=aggregated_2;
    /* Series plot with markers for individual data points and different line patterns for races */
    series x=year y=percent_preterm / group=race break markers lineattrs=(pattern=solid)
           markerattrs=(symbol=circlefilled size=6);
           
    /* Reference line for a specific threshold or year - adjust as required */
    refline 10 / axis=y lineattrs=(pattern=dash);

    /* Detailed axis settings */
    xaxis label="Year" display=(nolabel) values=(1975 to 2019 by 5);
    yaxis label="Percentage of Preterm Births" grid min=0 max=12;

    /* Title and legend */
    title "Trend in Preterm Births by Race (1975-2019)";
    keylegend / title="Race";
run;














/* #4-3 sorting the 43 datasets by RANDID.*/
/*
%macro sort_datasets;
  %let datasets = 	Ncube_Birth_StudyVars_1975 
					Ncube_Birth_StudyVars_1976
					Ncube_Birth_StudyVars_1977
					Ncube_Birth_StudyVars_1978
					Ncube_Birth_StudyVars_1979

					Ncube_Birth_StudyVars_1980
					Ncube_Birth_StudyVars_1981
					Ncube_Birth_StudyVars_1982
					Ncube_Birth_StudyVars_1984
					Ncube_Birth_StudyVars_1985
					Ncube_Birth_StudyVars_1986
					Ncube_Birth_StudyVars_1987
					Ncube_Birth_StudyVars_1988
					Ncube_Birth_StudyVars_1989

					Ncube_Birth_StudyVars_1990
					Ncube_Birth_StudyVars_1991
					Ncube_Birth_StudyVars_1992
					Ncube_Birth_StudyVars_1993
					Ncube_Birth_StudyVars_1994
					Ncube_Birth_StudyVars_1995
					Ncube_Birth_StudyVars_1996
					Ncube_Birth_StudyVars_1997
					Ncube_Birth_StudyVars_1998
					Ncube_Birth_StudyVars_1999

					Ncube_Birth_StudyVars_2000
					Ncube_Birth_StudyVars_2001
					Ncube_Birth_StudyVars_2002
					Ncube_Birth_StudyVars_2003
					Ncube_Birth_StudyVars_2004
					Ncube_Birth_StudyVars_2005
					Ncube_Birth_StudyVars_2006
					Ncube_Birth_StudyVars_2007
					Ncube_Birth_StudyVars_2008
					Ncube_Birth_StudyVars_2009

					Ncube_Birth_StudyVars_2010
					Ncube_Birth_StudyVars_2011
					Ncube_Birth_StudyVars_2012
					Ncube_Birth_StudyVars_2013
					Ncube_Birth_StudyVars_2014
					Ncube_Birth_StudyVars_2015
					Ncube_Birth_StudyVars_2016
					Ncube_Birth_StudyVars_2017
					Ncube_Birth_StudyVars_2018 
					Ncube_Birth_StudyVars_2019;

  %do i = 1 %to %sysfunc(countw(&datasets));
    %let ds = %scan(&datasets, &i);
    
    proc sort data=dummy.&ds;
      by RANDID;
    run;
  %end;
%mend;

%sort_datasets;


*/
	/* #4-4 merging the 43 datasets Horizantally.*/
/*
%macro merge_datasets;
  %let datasets = 	Ncube_Birth_StudyVars_1975 
					Ncube_Birth_StudyVars_1976
					Ncube_Birth_StudyVars_1977
					Ncube_Birth_StudyVars_1978
					Ncube_Birth_StudyVars_1979

					Ncube_Birth_StudyVars_1980
					Ncube_Birth_StudyVars_1981
					Ncube_Birth_StudyVars_1982
					Ncube_Birth_StudyVars_1984
					Ncube_Birth_StudyVars_1985
					Ncube_Birth_StudyVars_1986
					Ncube_Birth_StudyVars_1987
					Ncube_Birth_StudyVars_1988
					Ncube_Birth_StudyVars_1989

					Ncube_Birth_StudyVars_1990
					Ncube_Birth_StudyVars_1991
					Ncube_Birth_StudyVars_1992
					Ncube_Birth_StudyVars_1993
					Ncube_Birth_StudyVars_1994
					Ncube_Birth_StudyVars_1995
					Ncube_Birth_StudyVars_1996
					Ncube_Birth_StudyVars_1997
					Ncube_Birth_StudyVars_1998
					Ncube_Birth_StudyVars_1999

					Ncube_Birth_StudyVars_2000
					Ncube_Birth_StudyVars_2001
					Ncube_Birth_StudyVars_2002
					Ncube_Birth_StudyVars_2003
					Ncube_Birth_StudyVars_2004
					Ncube_Birth_StudyVars_2005
					Ncube_Birth_StudyVars_2006
					Ncube_Birth_StudyVars_2007
					Ncube_Birth_StudyVars_2008
					Ncube_Birth_StudyVars_2009

					Ncube_Birth_StudyVars_2010
					Ncube_Birth_StudyVars_2011
					Ncube_Birth_StudyVars_2012
					Ncube_Birth_StudyVars_2013
					Ncube_Birth_StudyVars_2014
					Ncube_Birth_StudyVars_2015
					Ncube_Birth_StudyVars_2016
					Ncube_Birth_StudyVars_2017
					Ncube_Birth_StudyVars_2018 
					Ncube_Birth_StudyVars_2019;

  data dummy.merged_Ncube_Birth;
    %do i = 1 %to %sysfunc(countw(&datasets));
      %let ds = %scan(&datasets, &i);
      set dummy.&ds;
    %end;
  run;
%mend;

%merge_datasets;
*/

/* 4-4 Vertical merging: Vertical Stacking (Appending) , stacking the observations of Dataset 2 under the observations of Dataset 1 ...etc*/

/*
data on.A_merged; 
set 	on.Ncube_Birth_StudyVars_1975
		on.Ncube_Birth_StudyVars_1976
		on.Ncube_Birth_StudyVars_1977
		on.Ncube_Birth_StudyVars_1978
		on.Ncube_Birth_StudyVars_1979

		on.Ncube_Birth_StudyVars_1980
		on.Ncube_Birth_StudyVars_1981
		on.Ncube_Birth_StudyVars_1982
		on.Ncube_Birth_StudyVars_1984
		on.Ncube_Birth_StudyVars_1985
		on.Ncube_Birth_StudyVars_1986
		on.Ncube_Birth_StudyVars_1987
		on.Ncube_Birth_StudyVars_1988
		on.Ncube_Birth_StudyVars_1989

		on.Ncube_Birth_StudyVars_1990
		on.Ncube_Birth_StudyVars_1991
		on.Ncube_Birth_StudyVars_1992
		on.Ncube_Birth_StudyVars_1993
		on.Ncube_Birth_StudyVars_1994
		on.Ncube_Birth_StudyVars_1995
		on.Ncube_Birth_StudyVars_1996
		on.Ncube_Birth_StudyVars_1997
		on.Ncube_Birth_StudyVars_1998
		on.Ncube_Birth_StudyVars_1999

		on.Ncube_Birth_StudyVars_2000
		on.Ncube_Birth_StudyVars_2001
		on.Ncube_Birth_StudyVars_2002
		on.Ncube_Birth_StudyVars_2003
		on.Ncube_Birth_StudyVars_2004
		on.Ncube_Birth_StudyVars_2005
		on.Ncube_Birth_StudyVars_2006
		on.Ncube_Birth_StudyVars_2007
		on.Ncube_Birth_StudyVars_2008
		on.Ncube_Birth_StudyVars_2009

		on.Ncube_Birth_StudyVars_2010
		on.Ncube_Birth_StudyVars_2011
		on.Ncube_Birth_StudyVars_2012
		on.Ncube_Birth_StudyVars_2013
		on.Ncube_Birth_StudyVars_2014
		on.Ncube_Birth_StudyVars_2015
		on.Ncube_Birth_StudyVars_2016
		on.Ncube_Birth_StudyVars_2017
		on.Ncube_Birth_StudyVars_2018
		on.Ncube_Birth_StudyVars_2019;
run;


*/















/*Manipulating individual datasets*/
/*
PROC CONTENTS DATA=dummy.Ncube_Birth_StudyVars_2014;
RUN;
DATA backup.Ncube_Birth_StudyVars_1982_num;
    SET backup.Ncube_Birth_StudyVars_1982;
    IF vtype(S_MRACE_6986) = 'C' THEN DO;
        S_MRACE_6986_num = INPUT(S_MRACE_6986, ?best12.);
        DROP S_MRACE_6986;
        RENAME S_MRACE_6986_num = S_MRACE_6986;
    END;
RUN;


*/







proc print data= merged_Ncube_Birth_StudyVars (obs=5); run;
/* Ddeleting datasest */
PROC DELETE DATA=libname.datasetname;RUN;
/* Data Manipulation: */









/* #3 Importing the individual 43 csv format datasets*/

/*70's*/
proc import out=proj.Ncube_Birth_StudyVars_1975 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1975.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1976 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1976.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1977 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1977.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1978 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1978.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1979 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1979.csv" DBMS=csv replace;  getnames=yes; run;
/*80's*/
proc import out=proj.Ncube_Birth_StudyVars_1980 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1980.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1981 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1981.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1982 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1982.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1984 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1984.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1985 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1985.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1986 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1986.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1987 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1987.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1988 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1988.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1989 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1989.csv" DBMS=csv replace;  getnames=yes; run;
/*90's*/
proc import out=proj.Ncube_Birth_StudyVars_1990 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1990.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1991 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1991.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1992 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1992.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1993 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1993.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1994 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1994.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1995 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1995.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1996 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1996.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1997 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1997.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1998 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1998.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_1999 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_1999.csv" DBMS=csv replace;  getnames=yes; run;
/*00's*/
proc import out=proj.Ncube_Birth_StudyVars_2000 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2000.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2001 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2001.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2002 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2002.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2003 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2003.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2004 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2004.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2005 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2005.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2006 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2006.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2007 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2007.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2008 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2008.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2009 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2009.csv" DBMS=csv replace;  getnames=yes; run;
/*10's*/
proc import out=proj.Ncube_Birth_StudyVars_2010 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2010.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2011 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2011.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2012 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2012.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2013 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2013.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2014 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2014.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2015 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2015.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2016 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2016.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2017 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2017.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2018 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2018.csv" DBMS=csv replace;  getnames=yes; run;
proc import out=proj.Ncube_Birth_StudyVars_2019 datafile="C:\Users\Basil\Documents\Department of Epidemiology\Data + Analysis\Data_Files_Full\Ncube_Birth_StudyVars_2019.csv" DBMS=csv replace;  getnames=yes; run;



/* converting in sum

%macro convert_variables;
  %let datasets = 	Ncube_Birth_StudyVars_1975 
					Ncube_Birth_StudyVars_1976
					Ncube_Birth_StudyVars_1977
					Ncube_Birth_StudyVars_1978
					Ncube_Birth_StudyVars_1979

					Ncube_Birth_StudyVars_1980
					Ncube_Birth_StudyVars_1981
					Ncube_Birth_StudyVars_1982
					Ncube_Birth_StudyVars_1984
					Ncube_Birth_StudyVars_1985
					Ncube_Birth_StudyVars_1986
					Ncube_Birth_StudyVars_1987
					Ncube_Birth_StudyVars_1988
					Ncube_Birth_StudyVars_1989

					Ncube_Birth_StudyVars_1990
					Ncube_Birth_StudyVars_1991
					Ncube_Birth_StudyVars_1992
					Ncube_Birth_StudyVars_1993
					Ncube_Birth_StudyVars_1994
					Ncube_Birth_StudyVars_1995
					Ncube_Birth_StudyVars_1996
					Ncube_Birth_StudyVars_1997
					Ncube_Birth_StudyVars_1998
					Ncube_Birth_StudyVars_1999

					Ncube_Birth_StudyVars_2000
					Ncube_Birth_StudyVars_2001
					Ncube_Birth_StudyVars_2002
					Ncube_Birth_StudyVars_2003
					Ncube_Birth_StudyVars_2004
					Ncube_Birth_StudyVars_2005
					Ncube_Birth_StudyVars_2006
					Ncube_Birth_StudyVars_2007
					Ncube_Birth_StudyVars_2008
					Ncube_Birth_StudyVars_2009

					Ncube_Birth_StudyVars_2010
					Ncube_Birth_StudyVars_2011
					Ncube_Birth_StudyVars_2012
					Ncube_Birth_StudyVars_2013
					Ncube_Birth_StudyVars_2014
					Ncube_Birth_StudyVars_2015
					Ncube_Birth_StudyVars_2016
					Ncube_Birth_StudyVars_2017
					Ncube_Birth_StudyVars_2018	 
					Ncube_Birth_StudyVars_2019;

  %do i = 1 %to %sysfunc(countw(&datasets));
    %let ds = %scan(&datasets, &i);
    
    data backup.&ds;
      set backup.&ds;
      if vtype(S_MRACE_6986) = 'C' then S_MRACE_6986 = input(S_MRACE_6986, ?best12.);
      if vtype(B_INFANT_SEX) = 'C' then B_INFANT_SEX = input(B_INFANT_SEX, ?best12.);
    run;
  %end;
%mend;
%convert_variables;
*/






/*

data data1975_temp;
	set proj.Ncube_Birth_StudyVars_1975;
run;
data data1976_temp;
	set proj.Ncube_Birth_StudyVars_1976;
run;


proc sort data=data1975_temp; by RANDID; run;
proc sort data=data1976_temp; by RANDID; run;
data merged_dummy; 
merge data1975_temp data1976_temp;
by RANDID;
run;
proc print data=merged_dummy (obs=5); run;

To find duplicates:

proc sort data=data1976_temp nodupkey dupout=duplicates_2;
   by RANDID;
run;

proc sql;
   create table common_ids as 
   select a.RANDID
   from data1975_temp as a, data1976_temp as b
   where a.RANDID = b.RANDID;
quit;

*/





/*##############################################################################################*/

%macro transform_dataset(dsname);

    data &dsname;
        set &dsname;
        /* Create a new numeric variable from the character variable */
        S_MRACE_6986_num = input(S_MRACE_6986, 1.);
        /* Drop the original character variable */
        drop S_MRACE_6986;
        /* Rename the new numeric variable back to the original variable name */
        rename S_MRACE_6986_num = S_MRACE_6986;
    run;

%mend;

%transform_dataset(main.Ncube_Birth_StudyVars_1982);
%transform_dataset(main.Ncube_Birth_StudyVars_1988);
%transform_dataset(main.Ncube_Birth_StudyVars_1989);
%transform_dataset(main.Ncube_Birth_StudyVars_1990);
%transform_dataset(main.Ncube_Birth_StudyVars_1992);
%transform_dataset(main.Ncube_Birth_StudyVars_1993);
%transform_dataset(main.Ncube_Birth_StudyVars_1998);
%transform_dataset(main.Ncube_Birth_StudyVars_2001);
%transform_dataset(main.Ncube_Birth_StudyVars_2004);
%transform_dataset(main.Ncube_Birth_StudyVars_2005);
%transform_dataset(main.Ncube_Birth_StudyVars_2006);
%transform_dataset(main.Ncube_Birth_StudyVars_2007);
%transform_dataset(main.Ncube_Birth_StudyVars_2008);
%transform_dataset(main.Ncube_Birth_StudyVars_2009);
%transform_dataset(main.Ncube_Birth_StudyVars_2010);

/*##############################################################################################*/

data on.Ncube_Birth_StudyVars_1982;
        set on.Ncube_Birth_StudyVars_1982;

        /* Reassign the values for the race variable */
        if S_MRACE_6986 in (4, 5, 6, 8) then S_MRACE_6986 = 4;
run;
