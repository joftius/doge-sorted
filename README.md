# Checking the `DOGE` website tables

The DOGE [website](https://doge.gov/savings) **wall of receipts** contains the following 'savings'[^1] totals:

| Table              | 'Savings' |
| :----------------- | ------: |
| Contracts       | $8.86B |
| Grants       | $10.30B |
| Real Estate       | $19.82B |

Estimate claimed by DOGE: **$105B**

Total of receipts: **$19.82B**

The website shows 'savings' in several tables, but these do not allow sorting by the amount.

This R script uses the [RSelenium](https://cran.r-project.org/web/packages/RSelenium/index.html) package to navigate a web browser to the site, click several text fields in order to reveal the full tables, and save the results. This allows sorting the data in R and saving it in any desired format.

CSV files and this [Google Sheet](https://docs.google.com/spreadsheets/d/13n8s4ZHESFeBTgyeFkol1WWaI_Ax5VvJ1gHuYGWXBow/edit?usp=sharing) both contain results saved after running this on 2025-03-04

[^1]: Basic financial literacy: many types of government spending are [investments](https://en.wikipedia.org/wiki/Fiscal_multiplier#United_States) with returns, so a dollar cut is not necessarily a dollar saved.
