
/*-------------------------------------
File: 01_clean.do
Purpose: Clean HCES 2023-24 data
Author: Vijayshree Jayaraman and Advait Moharir
Date: 31/01/2025
----------------------------------------*/

*-----------------------------------
*SECTION-1:LEVEL-1
*-------------------------------------


* Use the dictionary file to read the data
infix using "$dictionary/hces24_lvl_01.dct", ///
 using("$raw/hces24_lvl_01.txt") clear 

// destring and cleanup
gen hhid=fsu_serial_no+sec_stage_stratum_num+sample_hhld_num
destring year-sample_subdiv_num level-multiplier hhid,force replace
order hhid 

// save
save "$clean/level_01.dta", replace
export delimited using "$clean/level_01.csv", replace

*-----------------------------------
*SECTION-2 to 15:LEVEL-2 to 15 : Cleaning loop
*-------------------------------------
clear
local vals "02 03 04 05 06 07 08 09 10 11 12 13 14 15"
set trace on
foreach i in `vals'{
    * Use the dictionary file to read the data
    infix using "$dictionary/hces24_lvl_`i'.dct",using ("$raw/hces24_lvl_`i'.txt") clear 
  
    * Get hhid
    merge m:1 common_id using "$clean/level_01.dta", force nogen keep(3) keepusing(hhid)
    
    * Destring and cleanup
    drop common_id
    destring level-hhid, force replace
    order hhid
    
    * Save
    save "$clean/level_`i'.dta", replace
	export delimited "$clean/level_`i'.csv", replace
}
set trace off


