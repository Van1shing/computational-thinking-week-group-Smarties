# missing.R

# Install jsonlite if needed
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  install.packages("jsonlite", repos = "http://cran.rstudio.com/")
}
library(jsonlite)

# --- Path handling ---
# Get the directory of this script (works with Rscript)
args <- commandArgs(trailingOnly = FALSE)
script_path <- normalizePath(sub("--file=", "", args[grep("--file=", args)]))
script_dir <- dirname(script_path)

# Build paths relative to script folder
input_path  <- file.path(script_dir, "..", "fulldata", "data1.json")
output_path <- file.path(script_dir, "..", "testdata", "data2.json")

# --- Read JSON ---
json_text <- readLines(input_path, warn = FALSE)
json_data <- fromJSON(paste(json_text, collapse = ""))

# --- Process ---
# Convert the 'people' list to a data frame
people_df <- as.data.frame(json_data$people)

# Replace NAs with column means (numeric cols only)
for (col_name in names(people_df)) {
  if (is.numeric(people_df[[col_name]])) {
    col_mean <- mean(people_df[[col_name]], na.rm = TRUE)
    people_df[[col_name]][is.na(people_df[[col_name]])] <- col_mean
  }
}

# Replace the 'people' entry in the JSON
json_data$people <- people_df

# --- Write back ---
json_text <- toJSON(json_data, pretty = TRUE)
write(json_text, output_path)

cat("Processed JSON written to:", output_path, "\n")