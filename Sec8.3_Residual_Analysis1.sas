/* Section 8.3 - Example
Predictor Varaible: Car Weight (in 1000 pounds)
Response: Fuel Consumption (gallons/100 miles)
*/

DATA car;
      INPUT weight consumption @@;
      DATALINES;
 3.4    5.5
 3.8    5.9
 4.1    6.5
 2.2    3.3
 2.6    3.6
 2.9    4.6
 2.0    2.9
 2.7    3.6
 1.9    3.1
 3.4    4.9
   ;

PROC PRINT data=car;     /* Print out the data set*/
RUN;

PROC UNIVARIATE data=car;        /* provide the descriptive statistics*/
     var consumption weight;
RUN;


PROC REG data=car ;
     model  consumption=weight;        /* Model: y = a + b*x */
     title 'consumption vs weight';
     output out=Out r=Consum_Resid;
RUN;


PROC UNIVARIATE normal plot data=Out;  /* Analysis on residuals */
     var Consum_Resid;
RUN;


/* Boxcox Transformation if residuals do not look reasonable */
PROC TRANSREG DATA = car DETAIL;
	MODEL BOXCOX(consumption / convenient
		lambda = -3 to 3 by .125) = identity(weight);
	OUTPUT out = result2;
RUN;


