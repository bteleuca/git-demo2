cas casauto host="controller.sas-cas-server-default.gelenv.svc.cluster.local" port=5570;
* source caslib;
%let DM_SRC=DM;
* target caslib;
%let DM_TRG=Public;
* Your UserID;
%let userid=&sysuserid;

* Set active caslib;
options sessopts=(caslib="&DM_TRG" timeout=1800 locale="en_US" 	metrics="true");

* Load table;
proc casutil;
	droptable casdata="&userid._catcode" incaslib="&DM_TRG" quiet;
	load casdata="catcode.csv" casout="&userid._catcode" incaslib="&DM_SRC"
		outcaslib="&DM_TRG" copies=0 promote;
	quit;

cas casauto terminate;
