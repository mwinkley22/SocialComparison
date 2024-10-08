

*Envy 3 V1

*Selecting Approved Prolific IDS from Prolific Demographic Data
import delimited using "..\Prolific Information\EnvyExploration3V1_PIDs.csv", clear
keep if status=="APPROVED"

rename participantid PROLIFIC_PID
keep PROLIFIC_PID

tempfile temp1

save `temp1'

import excel using "..\Raw Excel Files\Envy+3+V1_October+3,+2024_16.45.xlsx", firstrow clear
*Cleaning variable description row and test/incomplete observations
drop in 1
keep if !missing(PROLIFIC_PID)
duplicates drop PROLIFIC_PID, force 
merge 1:1 PROLIFIC_PID using `temp1'


keep if _merge ==3 
drop _merge


destring case_*, force replace 


*Creating dummy variables (0,1) for each of the cases, 3 of them uniquely identify the other as this is a purely between subject design

gen case_a_tag = 1 if !missing(case_a_envy_1)
replace case_a_tag = 0 if missing(case_a_tag)

gen case_b_tag = 1 if !missing(case_b_envy_1)
replace case_b_tag = 0 if missing(case_b_tag)

gen case_c_tag = 1 if !missing(case_c_envy_1)
replace case_c_tag = 0 if missing(case_c_tag)

gen case_d_tag = 1 if !missing(case_d_envy_1)
replace case_d_tag = 0 if missing(case_d_tag)


local conds a b c d

gen general_envy = .
gen general_wtp = .
foreach arg of local conds {
	replace general_envy = case_`arg'_envy_1 if missing(general_envy)
	replace general_wtp = case_`arg'_wtp if missing(general_wtp)
}


keep PROLIFIC_PID WTP case_*_tag general_envy general_wtp case_*_wtp case_*_envy_1

label variable WTP "WTP (Tasks) for favorite artwork"

label variable case_a_tag "(0,0) -> (1,1)"
label variable case_b_tag "(0,0) -> (1,0)"
label variable case_c_tag "(0,1) -> (1,1)"
label variable case_d_tag "(0,1) -> (1,0)"

label variable general_wtp "WTP to obtain, destroy, or steal painting depending on cond."
label variable general_envy "Envy Level 0-10 of other participant"



gen str cases =  ""

foreach arg of local conds {
	replace cases = "`arg'" if case_`arg'_tag == 1
}

encode cases, gen(cases_numeric)

save "../Clean STATA Files/Envy_3_V1_clean.dtA", replace

log using "../Log Files/summarylog_envy3.smcl",replace 

describe, full 

summarize case* general_wtp general_envy

winsor2 general_wtp, trim cuts(5 95)


summarize case* general_wtp general_envy if !missing(general_wtp_tr)



reg general_wtp case_b_tag case_c_tag case_d_tag
reg general_wtp_tr case_b_tag case_c_tag case_d_tag


anova general_wtp_tr cases_numeric
pwcompare cases_numeric, mcompare(bonferroni)


reg general_wtp c.general_envy##case_b_tag c.general_envy#case_c_tag c.general_envy#case_d_tag

reg general_wtp_tr c.general_envy##case_b_tag c.general_envy#case_c_tag c.general_envy#case_d_tag

log off









*Envy 3 V2
*Change from Envy 3 V1: All subjects do Case A, and then are randomized into either B, C, or D



*Selecting Approved Prolific IDS from Prolific Demographic Data
import delimited using "..\Prolific Information\EnvyExploration3V2_PIDs.csv", clear
keep if status=="APPROVED"

rename participantid PROLIFIC_PID
keep PROLIFIC_PID

tempfile temp1

save `temp1'

import excel using "..\Raw Excel Files\Envy+3+V2_October+3,+2024_20.37.xlsx", firstrow clear

drop in 1

drop if Progress!= "100"
keep if !missing(PROLIFIC_PID)
duplicates drop PROLIFIC_PID, force 
merge 1:1 PROLIFIC_PID using `temp1'


keep if _merge ==3 
drop _merge


destring case_*, force replace 


foreach arg of local conds {
	winsor2 case_`arg'_wtp, trim cuts(5,95)
}

log on 
sum case_a_envy_1 case_b_envy_1 case_c_envy_1 case_d_envy_1 case_a_wtp case_b_wtp case_c_wtp case_d_wtp

sum case_a_envy_1 case_b_envy_1 case_c_envy_1 case_d_envy_1 case_a_wtp_tr case_b_wtp_tr case_c_wtp_tr case_d_wtp_tr

gen case_a_b = case_a_wtp_tr-case_b_wtp_tr
gen case_a_c = case_a_wtp_tr-case_c_wtp_tr
gen case_a_d = case_a_wtp_tr-case_d_wtp_tr


ttest case_a_b == 0
ttest case_a_c == 0
ttest case_a_d == 0


ttest case_a_b==case_a_c, unpaired
ttest case_a_b==case_a_d, unpaired
ttest case_a_c==case_a_d, unpaired


ttest case_a_b==case_a_c if case_c_envy_1>3, unpaired

log off







*Selecting Approved Prolific IDS from Prolific Demographic Data
import delimited using "..\Prolific Information\EnvyExploration3V3_PIDs.csv", clear
keep if status=="APPROVED"

rename participantid PROLIFIC_PID
keep PROLIFIC_PID

tempfile temp1

save `temp1'

import excel using "..\Raw Excel Files\Envy+3+V3_October+4,+2024_13.36.xlsx", firstrow clear

drop in 1

drop if Progress!= "100"
keep if !missing(PROLIFIC_PID)
duplicates drop PROLIFIC_PID, force 
merge 1:1 PROLIFIC_PID using `temp1'


keep if _merge ==3 
drop _merge



destring case_*, force replace 


local conds a c d 

foreach arg of local conds {
	winsor2 case_`arg'_wtp, trim cuts(5,95)
}

destring WTP, force replace 

gen general_wtp = case_c_wtp
replace general_wtp = case_d_wtp if missing(general_wtp)

gen general_envy = case_c_envy_1
replace general_envy = case_d_envy_1 if missing(general_envy)


gen case_c_tag= 1 if !missing(case_c_wtp)
replace case_c_tag= 0 if missing(case_c_tag)

gen case_d_tag= 1 if !missing(case_d_wtp)
replace case_d_tag=0 if missing(case_d_tag)

log on 

sum case_a_envy_1 case_c_envy_1 case_d_envy_1 case_a_wtp case_c_wtp case_d_wtp

sum case_a_envy_1 case_c_envy_1 case_d_envy_1 case_a_wtp_tr case_c_wtp_tr case_d_wtp_tr

reg general_wtp c.general_envy##i.case_c_tag i.case_c_tag##c.case_a_wtp



gen case_a_c = case_a_wtp_tr-case_c_wtp_tr
gen case_a_d = case_a_wtp_tr-case_d_wtp_tr

ttest case_a_c==0
ttest case_a_d==0


log close

