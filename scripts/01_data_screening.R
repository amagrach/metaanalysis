# library(remotes)
# 
# install_github("elizagrames/litsearchr", ref="main")
# Sys.getenv("GITHUB_PAT")
# Sys.unsetenv("GITHUB_PAT")



library(litsearchr)

##QUESTION
##What are the impacts of increasing honeybee hive density/abundance
#for wild pollinator and plant populations?


Naive search: 
  TITLE-ABS-KEY (( impact* OR effect* ) AND (( honeybee* OR (honey AND bee*) OR (apis AND mellifera ))) AND 
                 ( (wild AND pollinat*) OR plant ) AND (( ( nest* OR (reproduct* AND succe* )) OR 
                                                          ( abundance* OR presence* OR densit* ) ) OR ( population AND size ) OR 
                                                        ( surviv* OR mortalit* ) OR ( (food AND availab*) OR forag*)))

Scopus #hits = 1,977 on 12/03/2024

#Criteria to keep studies
#Criteria 1. Measures honeybee impacts in field or experimentally, no reviews or synthesis
#Criteria 2. Provides measure of honeybee hive density or abundance
#Criteria 3. Measures impact on other pollinator species or plants


library(metagear)

## Not run: 
df<-read.csv("data/scopus.csv")
str(df)
names(df)

# prime the study-reference dataset
theRefs <- effort_initialize(df)
# display the new columns added by effort_initialize 
names(theRefs)




effort_distribute(df,
                  initialize = TRUE,
                  reviewers = "ainhoa",
                  save_split = TRUE)
abstract_screener("effort_ainhoa.csv",
                  aReviewer = "ainhoa",
                  highlightKeywords = "and")

ef<-read.csv("effort_ainhoa.csv")
names(ef)

abstract_screener(
  file = file.choose("effort_ainhoa.csv"),
  aReviewer = "ainhoa",
  reviewerColumnName = "REVIEWERS",
  unscreenedColumnName = "INCLUDE",
  unscreenedValue = "not vetted",
  abstractColumnName = "Abstract",
  titleColumnName = "Title",
  browserSearch = "https://www.google.com/search?q=",
  fontSize = 13,
  windowWidth = 70,
  windowHeight = 16,
  theButtons = c("YES", "maybe", "NO"),
  keyBindingToButtons = c("y", "m", "n"),
  buttonSize = 10,
  highlightColor = "powderblue",
  highlightKeywords = NA
)


names(df)
df["Source.title"]

## End(Not run)

df<-litsearchr::import_results("../data/scopus.csv")

BBWO_import <- litsearchr::import_results(".../data/", remove_duplicates = FALSE, clean_dataset = TRUE, save_full_dataset = FALSE)
#> [1] "Importing file ../inst/extdata/biosis.txt"
#> [1] "Importing file ../inst/extdata/scopus.csv"
#> [1] "Importing file ../inst/extdata/zoorec.txt"
#> [1] "Cleaning dataset."
BBWO_data1 <- litsearchr::deduplicate(BBWO_import, use_abstracts = FALSE, use_titles=TRUE, method = "tokens", title_sim = .8)
BBWO_data <- litsearchr::deduplicate(BBWO_data1, use_abstracts = TRUE, use_titles=FALSE, doc_sim = .8, method="tokens")