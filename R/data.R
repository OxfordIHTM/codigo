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


#'
#' ICD-11 Mortality and Morbidity Linearization Outputs
#'
#' @format A data frame with 21 columns and 36753 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *Foundation URI* | Foundation URI |
#' | *Linearization (release) URI* | Linearization release URI |
#' | *Code* | ICD-11 Code |
#' | *BlockId* | Block identifier |
#' | *Title* | Title |
#' | *ClassKind* | Class |
#' | *DepthInKind* | Depth |
#' | *IsResidual* | Is residual? |
#' | *PrimaryLocation* | Primary location |
#' | *ChapterNo* | Chapter number |
#' | *BrowserLink* | Browser link |
#' | *iCatLink* | Category link |
#' | *isLeaf* | Is leaf? |
#' | *noOfNonResidualChildren* | Number of non-residual children |
#' | *Primary tabulation* | Primary tabulation |
#' | *Version* | Date and time linearization was produced |
#'
#' @examples
#' icd11_linearization_mms
#'
#' @source https://icd.who.int/dev11/Downloads/Download?fileName=LinearizationMiniOutput-MMS-en.zip
#'
"icd11_linearization_mms"


#'
#' ICD-11 Mortality and Morbidity Simple Table Outputs
#'
#' @format A data frame with 18 columns and 36044 rows:
#'
#' | **Variable** | **Description** |
#' | :--- | :--- |
#' | *Foundation URI* | Unique identifier for the entity that will not change |
#' | *Linearization (release) URI* | Unique identifier for this version of the classification. It includes the linearization name such as MMS and minor version identifier such as 2018 in it |
#' | *Code* | ICD-11 code for the entity. Note that the groupings do not have a code. |
#' | *BlockId* | Identifier for high level groupings that do not bear a code |
#' | *Title* | Title of the entity |
#' | *ClassKind* | One of the three (chapter, block, category); Chapter is top level classification entities; Blocks are high level groupings that do not bear a code; Categories are entities that has a code |
#' | *DepthInKind* | Depth of within the Class Kind. For example, a category with depthinkind=2 means it is category whose parent is also a category but grand parent is not |
#' | *IsResidual* | true if the entity is a residual category (i.e. other specified or unspecified categories) |
#' | *ChapterNo* | The chapter that the entity is in |
#' | *BrowserLink* | Direct link to this entity in ICD-11 browser |
#' | *IsLeaf* | true if this entity does not have any children |
#' | *Primary Tabulation* | |
#' | *GroupingX* | Groupings that the entity is included in |
#' | *Version* | Date and time linearization was produced |
#'
#' @examples
#' icd11_simple_table_mms
#'
#' @source https://icdcdn.who.int/static/releasefiles/2024-01/SimpleTabulation-ICD-11-MMS-en.zip
#'
"icd11_simple_table_mms"
