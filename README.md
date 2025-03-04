# Checking the `DOGE` website tables

`DOGE` currently claims a total savings of: *$105B*

Their `wall of receipts` contains the following totals:

| Table              | Savings |
| :----------------- | ------: |
| Contracts       | $8.90B |
| Grants       | $10.30B |
| Real Estate       | $0.66B |

Their [website](https://doge.gov/savings) shows `savings` in several tables, but these do not allow sorting by the amount.

This R script uses the [RSelenium](https://cran.r-project.org/web/packages/RSelenium/index.html) package to navigate a web browser to the site, click several text fields in order to reveal the full tables, and save the results. This allows sorting the data in R and saving it in any desired format.

CSV files and this [Google Sheet](https://docs.google.com/spreadsheets/d/13n8s4ZHESFeBTgyeFkol1WWaI_Ax5VvJ1gHuYGWXBow/edit?usp=sharing) both contain results saved after running this on 2025-03-04
