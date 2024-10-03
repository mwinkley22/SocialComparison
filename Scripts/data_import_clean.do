*Importing and cleaning the results for "Envy 2 V11"*
cd ..
import excel using ".\Raw Excel Files\Envy+2+V11_October+2,+2024_13.45.xlsx", firstrow clear

destring Progress, force replace
drop if Progress!=100


gen someone_else=1
gen v11=1


rename DesiretoPreventHigh DPH
rename DesiretoPreventLow DPL

rename HighWTP_EnvyLevel HEL
rename LowWTP_envylevel LEL


local select_vars WTP HEL DPH LEL DPL v11 someone_else WTP_high WTP_low


foreach arg of local select_vars {
	destring `arg', force replace
}
keep `select_vars' PROLIFIC_PID


*Envy 2 V11 Variable Labels
label variable WTP "# of tasks subject would be willing to do to receive favorite painting"
label variable HEL "Envy Level w/ higher WTP received painting for free on a scale of 1-10"
label variable LEL "Envy Level w/ lower WTP received painting for free on a scale of 1-10"
label variable DPH "# of tasks to prevent other (non prev) particip after High got for free"
label variable DPL "# of tasks to prevent other (non prev) particip after Low got for free"


label variable WTP_high "WTP of High WTP participant"
label variable WTP_low "WTP of Low WTP participant"



gen destroy_var = DPH
replace destroy_var = DPL if missing(DPH)

gen destroy_dummy = 1 if !missing(DPH)
replace destroy_dummy=0 if missing(destroy_dummy)

gen destroy_v_dum = destroy_var*destroy_dummy


gen envy_var = HEL
replace envy_var = LEL

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


log using "summarylog.scml", replace

/*
Envy 2 V11:

Key variation: eliciting WTP to prevent a random participant from receiving the painting **following** a High/Low WTP participant receiving your favorite painting.

Rank of Prevented Painting: Second Favorite

Within/Between: Between

Summary Statistics for Envy 2 V11:
*/

describe, full
tabstat `select_vars', stats(mean sd min max n) columns(var)





reg destroy_var envy_dummy envy_var envy_v_dum
reg destroy_var envy_dummy envy_var envy_v_dum WTP


log off








*Importing and cleaning the results for "Envy 2 V10"*
import excel using ".\Raw Excel Files\Envy+2+V10_October+2,+2024_14.24.xlsx", firstrow clear

destring Progress, force replace
drop if Progress!=100


gen someone_else=0
gen v10=1


rename DesiretoPreventHigh DPH
rename Q69 DPL

rename HighWTP_EnvyLevel HEL
rename LowWTP_envylevel LEL


local select_vars WTP HEL DPH LEL DPL v10 someone_else WTP_high WTP_low


foreach arg of local select_vars {
	destring `arg', force replace
}
keep `select_vars' PROLIFIC_PID

label variable WTP "# of tasks subject would be willing to do to receive favorite painting"
label variable HEL "Envy Level w/ higher WTP received painting for free on a scale of 1-10"
label variable LEL "Envy Level w/ lower WTP received painting for free on a scale of 1-10"
label variable DPH "# of tasks to prevent second favorite High WTP particip after they already received favorite"
label variable DPL "# of tasks to prevent second favorite Low WTP particip after they already received favorite"


label variable WTP_high "WTP of High WTP participant"
label variable WTP_low "WTP of Low WTP participant"


save ".\Clean STATA Files\Envy_2_V11_clean.dta",replace


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

log close

























