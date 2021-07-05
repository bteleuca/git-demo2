cas casauto host="controller.sas-cas-server-default.gelenv.svc.cluster.local" port=5570;

/* CASLIB Path data source accessible from the CAS controller */
/* points to mounted NFS gelcontent */

proc cas;
table.dropcaslib caslib="DM" quiet=true;
quit;

caslib DM path="/gelcontent/home/sasadm/devops/Data-Management/source_data/" type=path global;

caslib _ALL_ assign;

proc casutil ;
   list files incaslib="DM" ;
quit ;

cas casauto terminate;
