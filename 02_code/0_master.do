/*-------------------------------------
File: 0_master.do
Purpose: Set project roots
Author: Vijayshree Jayaraman and Advait Moharir
Date: 31/01/2025
----------------------------------------*/

// Prelims

set more off
clear all

// Set directory

** Uncomment and install this
*net install here, from("https://raw.githubusercontent.com/korenmiklos/here/master/")
here,set

// Folder paths

global raw "03_raw"
global code "02_code"
global clean "04_clean"
global dictionary "$code/dictionary"

