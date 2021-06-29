cas casauto;
caslib _ALL_ assign;

* Create dimension;
options dscas;
data PUBLIC.&sysuserid._CATCODE (promote=yes);
length CATCODE 8 CATALOG $50;
CATCODE=1; CATALOG="BIG FURNITURE";
CATCODE=2; CATALOG="SMALL FURNITURE";
run;
quit;

cas casauto terminate;