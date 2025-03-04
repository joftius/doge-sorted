library(RSelenium)
library(dplyr)
library(googlesheets4)
library(rvest)

# The receipts page
url <- "https://doge.gov/savings"

# Open a chrome browser, assumes chromedriver installed and running
# see https://cran.r-project.org/web/packages/RSelenium/readme/README.html
driver <- rsDriver(browser = "chrome", chromever=NULL, check=FALSE, port = 4565L)
# note the port, change if necessary
remDr <- driver[["client"]]

# Navigate to the page
remDr$navigate("https://doge.gov/savings")
Sys.sleep(4)

# Note: xpath for each element below can be found in chrome by
# right-click on the element, inspect, then in the panel showing
# source right-click again on the text and copy the full xpath

# Click Savings
#savings_button <- remDr$findElement(using = "xpath", "/html/body/div/main/div/div/div[4]/div/div[2]/span[2]")
savings_button <- remDr$findElement(using = "css selector", "#main-content > div > div > div.select-none.flex.justify-center.pb-10 > div > div.absolute.inset-0.flex.items-center.justify-between.px-4.text-white.text-sm.mona-sans > span:nth-child(2)")
savings_button$clickElement()
Sys.sleep(2)  

# Click see more for contracts
# /html/body/div/main/div/div/div[4]/div/table/tbody/tr[7]/td
# /html/body/div/main/div/div/div[5]/div[2]/div/div/button
#see_more_button <- remDr$findElement(using = "xpath", "/html/body/div/main/div/div/div[5]/div[2]/div/div/button")
see_more_button <- remDr$findElement(using = "xpath", "//button[text()='View All Contracts']")
see_more_button$clickElement()
Sys.sleep(3)  


# Click see more for grants
# /html/body/div/main/div/div/div[6]/div[2]/div/div/button
# //button[text()='View All Contracts']
#see_more_button <- remDr$findElement(using = "xpath", "/html/body/div/main/div/div/div[6]/div[2]/div/div/button")
see_more_button <- remDr$findElement(using = "xpath", "//button[text()='View All Grants']")
see_more_button$clickElement()
Sys.sleep(3)


# Click see more for real estate
# /html/body/div/main/div/div/div[5]/div/table/tbody/tr[7]/td
# /html/body/div/main/div/div/div[7]/div[2]/div/div/button
#see_more_button <- remDr$findElement(using = "xpath", "/html/body/div/main/div/div/div[7]/div[2]/div/div/button")
see_more_button <- remDr$findElement(using = "xpath", "//button[text()='View All Leases']")
see_more_button$clickElement()
Sys.sleep(2)

# Read full page
page_source <- remDr$getPageSource()[[1]]
page <- page_source |> read_html()

# Scrape tables
tables <- page |> html_nodes("table") |> html_table(fill = TRUE)

# Convert dollar strings to numeric and sort
contracts_table <- tables[[1]] |>
  mutate(Saved = as.numeric(gsub("[$,]", "", Saved))) |>
  arrange(desc(Saved)) |>
  select(-Link) # Drop empty column

# Convert dollar strings to numeric and sort
grants_table <- tables[[2]] |>
  mutate(Saved = as.numeric(gsub("[$,]", "", Saved))) |>
  arrange(desc(Saved))

# Convert dollar strings to numeric and sort
real_estate_table <- tables[[3]] |>
  mutate(Saved = as.numeric(gsub("[$,]", "", Saved))) |>
  arrange(desc(Saved))

# Total "saved"
sum(contracts_table$Saved)
sum(grants_table$Saved)
sum(real_estate_table$Saved)

# Close browser
remDr$close()
driver[["server"]]$stop()

# Save locally
readr::write_csv(contracts_table, "contracts.csv")
readr::write_csv(grants_table, "grants.csv")
readr::write_csv(real_estate_table, "realestate.csv")

# Save to Google Sheets
# Modify this with your own sheet id
# gs4_auth()
ss <- googledrive::as_id("13n8s4ZHESFeBTgyeFkol1WWaI_Ax5VvJ1gHuYGWXBow")
#sheet_delete(ss, sheet = "Sheet1")
sheet_write(contracts_table, ss, sheet = "Contracts")
sheet_write(grants_table, ss, sheet = "Grants")
sheet_write(real_estate_table, ss, sheet = "Real Estate")

