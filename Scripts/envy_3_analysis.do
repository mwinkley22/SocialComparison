

*Envy 3 V1

*Selecting Approved Prolific IDS from Prolific Demographic Data
import delimited using "C:\Users\Myles\OneDrive\Documents\Alex Research\SocialComparison\Prolific Information\EnvyExploration3V1_PIDs.csv", clear
keep if status=="APPROVED"

rename participantid PROLIFIC_PID
keep PROLIFIC_PID

tempfile temp1

save `temp1'

import excel using "C:\Users\Myles\OneDrive\Documents\Alex Research\SocialComparison\Raw Excel Files\Envy+3+V1_October+3,+2024_16.45.xlsx", firstrow clear
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
*Change from Envy 3 V1: 




log close