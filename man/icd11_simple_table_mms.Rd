% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{icd11_simple_table_mms}
\alias{icd11_simple_table_mms}
\title{ICD-11 Mortality and Morbidity Simple Table Outputs}
\format{
A data frame with 18 columns and 36044 rows:\tabular{ll}{
   \strong{Variable} \tab \strong{Description} \cr
   \emph{Foundation URI} \tab Unique identifier for the entity that will not change \cr
   \emph{Linearization (release) URI} \tab Unique identifier for this version of the classification. It includes the linearization name such as MMS and minor version identifier such as 2018 in it \cr
   \emph{Code} \tab ICD-11 code for the entity. Note that the groupings do not have a code. \cr
   \emph{BlockId} \tab Identifier for high level groupings that do not bear a code \cr
   \emph{Title} \tab Title of the entity \cr
   \emph{ClassKind} \tab One of the three (chapter, block, category); Chapter is top level classification entities; Blocks are high level groupings that do not bear a code; Categories are entities that has a code \cr
   \emph{DepthInKind} \tab Depth of within the Class Kind. For example, a category with depthinkind=2 means it is category whose parent is also a category but grand parent is not \cr
   \emph{IsResidual} \tab true if the entity is a residual category (i.e. other specified or unspecified categories) \cr
   \emph{ChapterNo} \tab The chapter that the entity is in \cr
   \emph{BrowserLink} \tab Direct link to this entity in ICD-11 browser \cr
   \emph{IsLeaf} \tab true if this entity does not have any children \cr
   \emph{Primary Tabulation} \tab  \cr
   \emph{GroupingX} \tab Groupings that the entity is included in \cr
   \emph{Version} \tab Date and time linearization was produced \cr
}
}
\source{
https://icdcdn.who.int/static/releasefiles/2024-01/SimpleTabulation-ICD-11-MMS-en.zip
}
\usage{
icd11_simple_table_mms
}
\description{
ICD-11 Mortality and Morbidity Simple Table Outputs
}
\examples{
icd11_simple_table_mms

}
\keyword{datasets}
