# Render every report in analysis/ to _site/ and build a landing page.
# Used by .github/workflows/render-reports.yml; also works locally:
#   Rscript render_site.R

reports <- sort(list.files("analysis", pattern = "\\.Rmd$", full.names = TRUE))
dir.create("_site", showWarnings = FALSE)

titles <- vapply(reports, function(f) {
  rmarkdown::yaml_front_matter(f)$title
}, character(1))

for (f in reports) {
  rmarkdown::render(f, output_dir = "_site", quiet = TRUE, envir = new.env())
}

links <- sprintf("%d. [%s](%s)", seq_along(reports), titles,
                 sub("\\.Rmd$", ".html", basename(reports)))

index <- tempfile(fileext = ".md")
writeLines(c(
  "---",
  "title: \"R for Quantitative Genetics\"",
  "subtitle: \"Rendered reports · Laide Abbas Rasaki\"",
  "output: html_document",
  "---",
  "",
  "Each report is rendered automatically from the R Markdown source on every push.",
  "",
  links,
  "",
  "Source code: [github.com/olaraym/R-Quantitative-Genetics-Portfolio](https://github.com/olaraym/R-Quantitative-Genetics-Portfolio)"
), index)
rmarkdown::render(index, output_file = "index.html", output_dir = "_site", quiet = TRUE,
                  output_options = list(theme = "flatly"))
