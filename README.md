# Sorting the "DOGE" website tables

The [DOGE](https://doge.gov/savings) website shows "savings" in several tables, but these do not allow sorting by the amount.

This R script uses the [RSelenium](https://cran.r-project.org/web/packages/RSelenium/index.html) package to navigate a web browser to the site, click several text fields in order to reveal the full tables, and save the results. This allows sorting the data in R and saving it in any desired format.

CSV files and the Google Sheet linked below both contain results saved after running this on February 26, 2025.

https://docs.google.com/spreadsheets/d/13n8s4ZHESFeBTgyeFkol1WWaI_Ax5VvJ1gHuYGWXBow/edit?usp=sharing
