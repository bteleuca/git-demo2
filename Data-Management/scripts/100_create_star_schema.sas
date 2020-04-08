cas casauto;

* source caslib;
%let DM_SRC=DM;

* target caslib;
%let DM_TRG=Public;

* Your UserID;
%let userid=<Your UserID (e.g. gatedemoxxx)>;

* Set active caslib;
options sessopts=(caslib="&DM_TRG" timeout=1800 locale="en_US" 	metrics="true");

* Drop STAR SCHEMA;
proc casutil incaslib="&DM_TRG";
	droptable casdata="&userid._star_schema" quiet;
	droptable casdata="&userid._star_schema_agg" quiet;
	droptable casdata="&userid._star_schema_tr" quiet;
	droptable casdata="&userid._star_schema_test" quiet;
quit;

* CAS Star Schema;
proc cas; 
table.view / caslib="&DM_TRG" name="&userid._star_schema" promote=true
tables={
	{caslib="&DM_TRG" name="&userid._mailorder", 
	varlist={'Qty', 'Date'}, as='m'},
	{keys={'m_pcode = p_pcode'},
    caslib="&DM_TRG" name="&userid._products",  varlist={'price','cost', 'descrip','type'}, 
	computedVars={{name="price_cost_ratio"}}, computedVarsProgram="price_cost_ratio = price/cost;",	as='p'},
	{keys={'m_custnum = c_custnum'},
    caslib="&DM_TRG" name="&userid._customers", 
	varList={'addr1','addr2','city','phone',
	'region','state','zip'}, as='c'},
	{keys={'m_catcode = cat_catcode'},
    caslib="&DM_TRG" name="&userid._catcode", varlist={'catalog'}, as='cat'}
	};
quit;

cas casauto terminate;