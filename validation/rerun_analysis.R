# Render the revised R workflow and save aggregate metrics.
arguments <- commandArgs(trailingOnly = FALSE)
script_file <- sub("^--file=", "", arguments[grepl("^--file=", arguments)][1])
root <- normalizePath(file.path(dirname(script_file), ".."))
setwd(root)
source_file <- "Notebooks/housing_outlier_regression.Rmd"
e <- new.env(parent = globalenv())
output <- rmarkdown::render(source_file, output_file = "executed_workflow.html",
    output_dir = file.path(root, "Reports"), envir = e, quiet = TRUE)
result <- list(before_rows=nrow(e$before),after_rows=nrow(e$after),flagged_rows=length(e$flagged),scenario_replacements=length(e$replaceable),before_model_n=nobs(e$before_model),after_model_n=nobs(e$after_model),scenario_model_n=nobs(e$scenario_model),before_fitting_r2=summary(e$before_model)$r.squared,after_fitting_r2=summary(e$after_model)$r.squared,scenario_fitting_r2=summary(e$scenario_model)$r.squared)
packages <- c("knitr","rmarkdown","jsonlite","dplyr","ggplot2","forecast","vars","rpart","ggfortify","broom","nycflights13")
versions <- setNames(lapply(packages,function(p) if(requireNamespace(p,quietly=TRUE)) as.character(packageVersion(p)) else NA_character_),packages)
result$checked_at_utc <- format(Sys.time(), tz="UTC", usetz=TRUE)
result$R_version <- R.version.string
result$package_versions <- versions
result$source <- source_file
result$scope <- "Revised R Markdown workflow executed and rendered; archived historical analyses are not claimed as reproduced when preprocessing or evaluation changed."
jsonlite::write_json(result, "Reports/validation_results.json", pretty=TRUE, auto_unbox=TRUE, na="null", digits=12)
writeLines(capture.output(sessionInfo()), "Reports/validated_session.txt")
cat(jsonlite::toJSON(result,pretty=TRUE,auto_unbox=TRUE,na="null",digits=12),"\n")
