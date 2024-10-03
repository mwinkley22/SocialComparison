*Importing and cleaning the results for "Envy 2 V11"*
cd ..
import excel using ".\Raw Excel Files\Envy+2+V11_October+2,+2024_13.45.xlsx", firstrow clear

destring Progress, force replace
drop if Progress!=100
drop if missing(PROLIFIC_PID)

gen someone_else=1
gen v11=1


rename DesiretoPreventHigh WTP_PH
rename DesiretoPreventLow WTP_PL

rename HighWTP_EnvyLevel HEL
rename LowWTP_envylevel LEL


local select_vars WTP HEL WTP_PH LEL WTP_PL v11 someone_else WTP_high WTP_low wtpHighLowCondition

replace wtpHighLowCondition = "1" if wtpHighLowCondition == "high"
replace wtpHighLowCondition = "0" if wtpHighLowCondition == "low"


foreach arg of local select_vars {
	destring `arg', force replace
}
keep `select_vars' PROLIFIC_PID


*Envy 2 V11 Variable Labels
label variable WTP "# of tasks subject would be willing to do to receive favorite painting"
label variable HEL "Envy Level w/ higher WTP received painting for free on a scale of 1-10"
label variable LEL "Envy Level w/ lower WTP received painting for free on a scale of 1-10"
label variable WTP_PH "# of tasks to prevent other (non prev) particip after High got for free"
label variable WTP_PL "# of tasks to prevent other (non prev) particip after Low got for free"
label variable WTP "WTP for favorite painting"


label variable WTP_high "WTP of High WTP participant"
label variable WTP_low "WTP of Low WTP participant"

label variable wtpHighLowCondition "1 if High condition, 0 if low condition"

gen destroy_var = WTP_PH
replace destroy_var = WTP_PL if missing(WTP_PH)

gen destroy_dummy = 1 if !missing(WTP_PH)
replace destroy_dummy=0 if missing(destroy_dummy)

gen destroy_v_dum = destroy_var*destroy_dummy


gen envy_var = HEL
replace envy_var = LEL if missing(envy_var)

gen envy_dummy = 1 if !missing(HEL)
replace envy_dummy = 0 if missing(envy_dummy)

gen envy_v_dum = envy_var*envy_dummy

label variable destroy_var "WTP to Prevent, both treatments"
label variable destroy_dummy "1 if High treatment, 0 if Low"
label variable destroy_v_dum "destroy_var*destroy_dummy"

label variable envy_var "Envy, both treatments"
label variable envy_dummy "1 if High treatment, 0 if Low"
label variable envy_v_dum "envy_var*envy_dummy"


save ".\Clean STATA Files\Envy_2_V11_clean.dta",replace


log using "summarylog.smcl", replace

/*
Envy 2 V11:

Key variation: eliciting WTP to prevent a random participant from receiving the painting **following** a High/Low WTP participant receiving your favorite painting.

Rank of Prevented Painting: Second Favorite

Within/Between: Between

Summary Statistics for Envy 2 V11:
*/

describe, full
tabstat `select_vars', stats(mean sd min max n) columns(var)





reg destroy_var c.envy_var##i.wtpHighLowCondition
reg destroy_var c.envy_var##i.wtpHighLowCondition WTP

log off







*Importing and cleaning the results for "Envy 2 V10"*
import excel using ".\Raw Excel Files\Envy+2+V10_October+2,+2024_14.24.xlsx", firstrow clear


destring Progress, force replace
drop if Progress!=100
drop if missing(PROLIFIC_PID)

gen someone_else=1
gen v10=1


rename DesiretoPreventHigh WTP_PH
rename Q69 WTP_PL

rename HighWTP_EnvyLevel HEL
rename LowWTP_envylevel LEL


local select_vars WTP HEL WTP_PH LEL WTP_PL v10 someone_else WTP_high WTP_low wtpHighLowCondition

replace wtpHighLowCondition = "1" if wtpHighLowCondition == "high"
replace wtpHighLowCondition = "0" if wtpHighLowCondition == "low"


foreach arg of local select_vars {
	destring `arg', force replace
}
keep `select_vars' PROLIFIC_PID


*Envy 2 V10 Variable Labels
label variable WTP "# of tasks subject would be willing to do to receive favorite painting"
label variable HEL "Envy Level w/ higher WTP received painting for free on a scale of 1-10"
label variable LEL "Envy Level w/ lower WTP received painting for free on a scale of 1-10"
label variable WTP_PH "# of tasks to prevent other (non prev) particip after High got for free"
label variable WTP_PL "# of tasks to prevent other (non prev) particip after Low got for free"
label variable WTP "WTP for favorite painting"


label variable WTP_high "WTP of High WTP participant"
label variable WTP_low "WTP of Low WTP participant"

label variable wtpHighLowCondition "1 if High condition, 0 if low condition"

gen destroy_var = WTP_PH
replace destroy_var = WTP_PL if missing(WTP_PH)

gen destroy_dummy = 1 if !missing(WTP_PH)
replace destroy_dummy=0 if missing(destroy_dummy)

gen destroy_v_dum = destroy_var*destroy_dummy


gen envy_var = HEL
replace envy_var = LEL if missing(envy_var)

gen envy_dummy = 1 if !missing(HEL)
replace envy_dummy = 0 if missing(envy_dummy)

gen envy_v_dum = envy_var*envy_dummy

label variable destroy_var "WTP to Prevent, both treatments"
label variable destroy_dummy "1 if High treatment, 0 if Low"
label variable destroy_v_dum "destroy_var*destroy_dummy"

label variable envy_var "Envy, both treatments"
label variable envy_dummy "1 if High treatment, 0 if Low"
label variable envy_v_dum "envy_var*envy_dummy"



save ".\Clean STATA Files\Envy_2_V10_clean.dta",replace


log on

/*
Envy 2 V10:

Key variation: eliciting WTP to prevent High/Low WTP participant receiving your second favorite painting **following** them already having received your favorite. Your second favorite painting is rated highly by *both* participants

Rank of Prevented Painting: Second Favorite

Within/Between: Between

Summary Statistics for Envy 2 V10:
*/

describe, full
tabstat `select_vars', stats(mean sd min max n) columns(var)





reg destroy_var c.envy_var##i.wtpHighLowCondition
reg destroy_var c.envy_var##i.wtpHighLowCondition WTP

log off










*Importing and cleaning the results for "Envy 2 V10"*
import excel using ".\Raw Excel Files\Envy+2+V9_October+3,+2024_13.42.xlsx", firstrow clear
gen someone_else=0
gen v9=1


destring Progress, force replace
drop if Progress!=100
drop if missing(PROLIFIC_PID)


rename WTPtoPreventHigh WTP_PH
rename WTPtoPreventLow WTP_PL

rename DesiretoPreventHigh_1 DPH
rename DesiretoPreventLow_1 DPL


local select_vars WTP WTP_PH DPH WTP_PL DPL v9 someone_else WTP_high WTP_low wtpHighLowCondition

replace wtpHighLowCondition = "1" if wtpHighLowCondition == "high"
replace wtpHighLowCondition = "0" if wtpHighLowCondition == "low"


foreach arg of local select_vars {
	destring `arg', force replace
}
keep `select_vars' PROLIFIC_PID


*Envy 2 V10 Variable Labels
label variable WTP "# of tasks subject would be willing to do to receive favorite painting"
label variable DPH "Desire to Prevent High from getting painting for free on a scale of 1-10"
label variable DPL "Desire to Prevent High from getting painting for free on a scale of 1-10"
label variable WTP_PH "# of tasks to prevent other (non prev) particip after High got for free"
label variable WTP_PL "# of tasks to prevent other (non prev) particip after Low got for free"
label variable WTP "WTP for favorite painting"


label variable WTP_high "WTP of High WTP participant"
label variable WTP_low "WTP of Low WTP participant"

label variable wtpHighLowCondition "1 if High condition, 0 if low condition"

gen destroy_var = WTP_PH
replace destroy_var = WTP_PL if missing(WTP_PH)

gen destroy_dummy = 1 if !missing(WTP_PH)
replace destroy_dummy=0 if missing(destroy_dummy)

gen destroy_v_dum = destroy_var*destroy_dummy


gen dp_var = DPH
replace dp_var = DPL if missing(dp_var)

gen dp_dummy = 1 if !missing(DPH)
replace dp_dummy = 0 if missing(dp_dummy)

gen dp_v_dum = dp_var*dp_dummy

label variable destroy_var "WTP to Prevent, both treatments"
label variable destroy_dummy "1 if High treatment, 0 if Low"
label variable destroy_v_dum "destroy_var*destroy_dummy"

label variable dp_var "Desire to Prevent, both treatments"
label variable dp_dummy "1 if High treatment, 0 if Low"
label variable dp_v_dum "dp_var*dp_dummy"



save ".\Clean STATA Files\Envy_2_V9_clean.dta",replace


log on

/*
Envy 2 V9:

Key variation: Removing mentions of envy and envy questions, replacing the Envy slider questions with "desire to prevent"

Rank of Prevented Painting: Favorite

Within/Between: Between

Summary Statistics for Envy 2 V10:
*/

describe, full
tabstat `select_vars', stats(mean sd min max n) columns(var)





reg destroy_var c.dp_var##i.wtpHighLowCondition
reg destroy_var c.dp_var##i.wtpHighLowCondition WTP

log off













*Importing and cleaning the results for "Envy 2 V10"*

tempfile temp1 
import excel using ".\Raw Excel Files\Envy+2+V4_October+3,+2024_14.05.xlsx", firstrow clear

save temp1


import excel using ".\Raw Excel Files\Envy+2+V6_October+3,+2024_14.45.xlsx", firstrow clear

append using temp1 
 
destring Progress, force replace
drop if Progress!=100
drop if missing(PROLIFIC_PID)

gen someone_else=0
gen v4=1




rename Destroy_WTP_High WTP_Prevent_High
rename Destroy_WTP_Low WTP_Prevent_Low

rename EnvyLevel_WTP_High Envy_Level_High
rename EnvyLevel_WTP_low  Envy_Level_Low


local select_vars WTP WTP_Prevent_High WTP_Prevent_Low Envy_Level_High Envy_Level_Low WTP_high WTP_low



foreach arg of local select_vars {
	destring `arg', force replace
}
keep `select_vars' PROLIFIC_PID



reshape long WTP_Prevent Envy_Level, i(PROLIFIC_PID) j(treatment) string

replace treatment = "0" if treatment=="_Low"
replace treatment = "1" if treatment=="_High"

destring treatment, force replace

rename treatment hypothetical

label variable hypothetical "=1 if other particip High WTP =0 if Low "
label variable WTP_Prevent "WTP in tasks to prevent other participant from receiving for free"
label variable Envy_Level "Envy Level (0-10) if other participant received for free (hypo)"
label variable WTP "WTP for favorite painting"
label variable WTP_high "WTP of High WTP participant"
label variable WTP_low "WTP of Low WTP participant"

save ".\Clean STATA Files\Envy_2_V4_clean.dta",replace


log on

/*
Envy 2 V4:

Key variation: "Base Case" for following envy studies. i.e. envy sliders 0-10 (some others are 1-10), task WTP, how much would you work to prevent favorite painting from going to a high/low WTP person

Rank of Prevented Painting: Favorite

Within/Between: Within

Summary Statistics for Envy 2 V4:
*/

describe, full
bysort hypothetical: tabstat WTP_Prevent Envy_Level, stats(mean sd min max n)





reg WTP_Prevent c.Envy_Level##i.hypothetical
reg WTP_Prevent c.Envy_Level##i.hypothetical WTP

log off


























log close 













