#'
#' Table of supported classifications and versions by the ICD API
#'
#' @format A data frame with 6 columns and 11 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *Classification* | Version of classification. Either ICD-11 or ICD-10 |
#' | *Release ID* | Release identifier for specific classification version |
#' | *Foundation* | Logical. Does this version include the Foundation? |
#' | *MMS* | Logical. Does this version include the MMS information? |
#' | *ICF* | Logical. Does this version include the ICF? |
#' | *Languages* | Languages in which version and release is available for |
#'
#' For logical fields that specify NA, this indicates that for that particular
#' version and release, the particular field was not applicable or relevant.
#'
#' @examples
#' icd_versions
#'
#' @source https://icd.who.int/docs/icd-api/SupportedClassifications/
#'
"icd_versions"
