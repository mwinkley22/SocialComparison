~~~~
*STATA/SE 18.0
*Author: Myles Winkleyu
*Title: Envy_Summarize_Oct2.do
*Compiling Envy studies and results up to 10/2/2024
~~~~



<<dd_do: quietly>>
*Importing and cleaning the results for "Envy 2 V11"*
cd "C:\Users\winkley\Documents\Social Comparison\Social Comparison Summary"
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

label variable WTP "# of tasks subject would be willing to do to receive favorite painting"
label variable HEL "Envy Level w/ higher WTP received painting for free on a scale of 1-10"
label variable LEL "Envy Level w/ lower WTP received painting for free on a scale of 1-10"
label variable DPH "# of tasks to prevent other (non prev) particip after High got for free"
label variable DPL "# of tasks to prevent other (non prev) particip after Low got for free"


label variable WTP_high "WTP of High WTP participant"
label variable WTP_low "WTP of Low WTP participant"


save ".\Clean STATA Files\Envy_2_V11_clean.dta",replace
<</dd_do>>



~~~~

Envy 2 V11:

Key variation: eliciting WTP to prevent a random participant from receiving the painting **following** a High/Low WTP participant receiving your favorite painting.

Rank of Prevented Painting: Second Favorite

Within/Between: Between

Summary Statistics for Envy 2 V11:
<<dd_do:nocommand>>

describe, full
tabstat `select_vars', stats(mean sd min max n) columns(var)
<</dd_do>>
~~~~








<<dd_do: quietly>>
*Importing and cleaning the results for "Envy 2 V10"*
cd "C:\Users\winkley\Documents\Social Comparison\Social Comparison Summary"
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
<</dd_do>>



~~~~

Envy 2 V10: How much

Key variation: eliciting WTP to prevent High/Low WTP participant receiving your second favorite painting **following** them already having received your favorite

Rank of Prevented Painting: Second Favorite

Within/Between: Between

Summary Statistics for Envy 2 V10:
<<dd_do:nocommand>>

describe, full
tabstat `select_vars', stats(mean sd min max n) columns(var)
<</dd_do>>
~~~~

<<dd_do>>
ttest HEL

















