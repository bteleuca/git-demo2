cas casauto;
caslib _all_ assign;
proc casutil incaslib=”Public”;
list files; list tables;
quit;
cas casauto terminate;
