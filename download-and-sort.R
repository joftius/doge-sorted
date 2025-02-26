library(RSelenium)
library(dplyr)
library(googlesheets4)

# The receipts page
url <- "https://doge.gov/savings"

# Open a chrome browser, assumes chromedriver installed and running
# see https://cran.r-project.org/web/packages/RSelenium/readme/README.html
driver <- rsDriver(browser = "chrome", chromever=NULL, check=FALSE, port = 4568L)
# note the port, change if necessary
remDr <- driver[["client"]]

# Navigate to the page
remDr$navigate("https://doge.gov/savings")
Sys.sleep(4)

# Note: xpath for each element below can be found in chrome by
# right-click on the element, inspect, then in the panel showing
# source right-click again on the text and copy the full xpath

# Click Savings
savings_button <- remDr$findElement(using = "xpath", "/html/body/div/main/div/div/div[3]/div/div/div[2]/span[2]")
savings_button$clickElement()
Sys.sleep(2)  

# Click see more for contracts
see_more_button <- remDr$findElement(using = "xpath", "/html/body/div/main/div/div/div[4]/div/table/tbody/tr[7]/td")
see_more_button$clickElement()
Sys.sleep(2)  

# Click see more for real estate
see_more_button <- remDr$findElement(using = "xpath", "/html/body/div/main/div/div/div[5]/div/table/tbody/tr[7]/td")
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
real_estate_table <- tables[[2]] |>
  mutate(Saved = as.numeric(gsub("[$,]", "", Saved))) |>
  arrange(desc(Saved))

# Total "saved"
sum(contracts_table$Saved)
sum(real_estate_table$Saved)

# Close browser
remDr$close()
driver[["server"]]$stop()

# Save locally
readr::write_csv(contracts_table, "contracts.csv")
readr::write_csv(real_estate_table, "realestate.csv")

# Save to Google Sheets
# Modify this with your own sheet id
# gs4_auth()
ss <- googledrive::as_id("13n8s4ZHESFeBTgyeFkol1WWaI_Ax5VvJ1gHuYGWXBow")
sheet_delete(ss, sheet = "Sheet1")
sheet_write(contracts_table, ss, sheet = "Contracts")
sheet_write(real_estate_table, ss, sheet = "Real Estate")

