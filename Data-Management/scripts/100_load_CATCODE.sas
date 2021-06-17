cas casauto;
caslib _ALL_ assign;

* Create some fictitious data;
options dscas;
data CASUSER.CATCODE;
length CATCODE 8 CATALOG $50;
CATCODE=1; CATALOG="BIG FURNITURE";
CATCODE=2; CATALOG="SMALL FURNITURE";
run;

* source caslib;
%let DM_SRC=CASUSER;

* target caslib;
%let DM_TRG=Public;

* Your UserID;
%let userid=&sysuserid;

* Load files into target caslib;
* Drop first;
proc casutil incaslib="&DM_TRG";
	droptable casdata="&userid._catcode" quiet;
quit;

* Save;
proc casutil;
	save casdata='CATCODE' incaslib='casuser' casout='&userid._catcode'  outcaslib='Public' copies=0;
quit;

cas casauto terminate;
