* The code example assumes: a source caslib, target caslib and several .csv files present in the source caslib;

* host;
cas casauto;

* source caslib;
%let DM_SRC=DM;

* target caslib;
%let DM_TRG=Public;

* Your UserID;
%let userid=&sysuserid ;

* Drop target tables first;
proc casutil incaslib="&DM_TRG";
	droptable casdata="&userid._catcode" quiet;
	droptable casdata="&userid._mailorder" quiet;
	droptable casdata="&userid._products" quiet;
	droptable casdata="&userid._customers" quiet;
quit;

* Load files into target caslib;
proc casutil incaslib="&DM_SRC" outcaslib="&DM_TRG";
	load casdata="catcode.csv" casout="&userid._catcode" copies=0 promote;
	load casdata="mailorder.csv" casout="&userid._mailorder" copies=0 promote;
	load casdata="products.csv" casout="&userid._products" copies=0 promote;
	load casdata="customers.csv" casout="&userid._customers" copies=0 promote;
quit;

cas casauto terminate;
