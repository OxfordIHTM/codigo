# Get information on various ICD-11 foundation and linearization entities

Get information on various ICD-11 foundation and linearization entities

## Usage

``` r
icd_get_foundation(
  release = NULL,
  api_version = c("v2", "v1"),
  language = "en",
  tabular = TRUE,
  verbose = TRUE,
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access",
  timeout = 30,
  max_tries = 3
)

icd_get_entity(
  id,
  release = NULL,
  include = NULL,
  api_version = c("v2", "v1"),
  language = "en",
  verbose = TRUE,
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access",
  timeout = 30,
  max_tries = 3
)

icd_get_info(
  linearization = c("mms", "icf"),
  api_version = c("v2", "v1"),
  language = "en",
  verbose = TRUE,
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access",
  timeout = 30,
  max_tries = 3
)

icd_get_chapter(
  linearization = c("mms", "icf"),
  release = NULL,
  api_version = c("v2", "v1"),
  language = "en",
  verbose = TRUE,
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access",
  timeout = 30,
  max_tries = 3
)
```

## Arguments

- release:

  A string specifying the release version to search from. If not
  specified, defaults to the latest available release version. See the
  available versions for each ICD classification with `icd_versions`.

- api_version:

  Version of the API. Possible values are `v1` or `v2`. Default is `v2`.

- language:

  ICD-API is multi-lingual. Language codes such as "en", "es", "zh",
  etc. Default is English ("en").

- tabular:

  Logical. Should output be structured into a tibble? Default is TRUE.

- verbose:

  Logical. Should non-warning and non-error messages be printed? Default
  is TRUE.

- base_url:

  The base URL of the API. Default uses the WHO API server at
  https://id.who.int.

- client:

  The OAuth2 client produced through a call to
  [`icd_oauth_client()`](https://oxford-ihtm.io/codigo/reference/icd_authenticate.md).

- scope:

  Scopes to be requested from the resource owner. Default is
  *"icdapi_access"* as specified in the ICD API documentation.

- timeout:

  The maximum time to wait for a response from the API server in
  seconds. Default is 30 seconds.

- max_tries:

  Maximum number of times to retry a request if it fails with a
  transient error (e.g. 429, 500, 503). Default is 3.

- id:

  Unique numerical identifier for an entity.

- include:

  A string or a vector of strings for optional property values to be
  included in the response. The property values that can be included are
  *"ancestor"*, *"descendant"*, or *"diagnosticCriteria"*. If not
  specified, these properties are not included in the response.

- linearization:

  A character value for which linearization to search. Currently, the
  possible values are *"mms"* and *"icf"*. Default is *"mms"*.

## Value

A list with information on specified ICD 11 Foundation and top level
entities.

## Examples

``` r
# \donttest{
  icd_get_foundation()
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> # A tibble: 1 × 11
#>   `@context`        `@id` `title_@language` `title_@value` releaseId releaseDate
#>   <chr>             <chr> <chr>             <chr>          <chr>     <chr>      
#> 1 http://id.who.in… http… en                WHO Family of… 2026-01   2026-01-17 
#> # ℹ 5 more variables: availableLanguages <list>, allReleases <list>,
#> #   includedLinearizations <list>, child <list>, browserUrl <chr>
  icd_get_entity(id = "1435254666")     ## chapter
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForFoundationEntity.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/entity/1435254666"
#> 
#> $parent
#> $parent[[1]]
#> [1] "http://id.who.int/icd/entity/455013390"
#> 
#> 
#> $child
#> $child[[1]]
#> [1] "http://id.who.int/icd/entity/588616678"
#> 
#> $child[[2]]
#> [1] "http://id.who.int/icd/entity/1904876434"
#> 
#> $child[[3]]
#> [1] "http://id.who.int/icd/entity/979278646"
#> 
#> $child[[4]]
#> [1] "http://id.who.int/icd/entity/1539889147"
#> 
#> $child[[5]]
#> [1] "http://id.who.int/icd/entity/1412960686"
#> 
#> $child[[6]]
#> [1] "http://id.who.int/icd/entity/1935092859"
#> 
#> $child[[7]]
#> [1] "http://id.who.int/icd/entity/487269828"
#> 
#> $child[[8]]
#> [1] "http://id.who.int/icd/entity/1000704511"
#> 
#> $child[[9]]
#> [1] "http://id.who.int/icd/entity/1104303944"
#> 
#> $child[[10]]
#> [1] "http://id.who.int/icd/entity/1585949804"
#> 
#> $child[[11]]
#> [1] "http://id.who.int/icd/entity/1959883044"
#> 
#> $child[[12]]
#> [1] "http://id.who.int/icd/entity/921595235"
#> 
#> $child[[13]]
#> [1] "http://id.who.int/icd/entity/1251496839"
#> 
#> $child[[14]]
#> [1] "http://id.who.int/icd/entity/1136802325"
#> 
#> $child[[15]]
#> [1] "http://id.who.int/icd/entity/145723401"
#> 
#> $child[[16]]
#> [1] "http://id.who.int/icd/entity/985510409"
#> 
#> $child[[17]]
#> [1] "http://id.who.int/icd/entity/1646490591"
#> 
#> $child[[18]]
#> [1] "http://id.who.int/icd/entity/1939815950"
#> 
#> $child[[19]]
#> [1] "http://id.who.int/icd/entity/255141529"
#> 
#> $child[[20]]
#> [1] "http://id.who.int/icd/entity/293771399"
#> 
#> $child[[21]]
#> [1] "http://id.who.int/icd/entity/5960175"
#> 
#> $child[[22]]
#> [1] "http://id.who.int/icd/entity/911707612"
#> 
#> $child[[23]]
#> [1] "http://id.who.int/icd/entity/1965146397"
#> 
#> $child[[24]]
#> [1] "http://id.who.int/icd/entity/142052508"
#> 
#> $child[[25]]
#> [1] "http://id.who.int/icd/entity/1760597414"
#> 
#> $child[[26]]
#> [1] "http://id.who.int/icd/entity/458687859"
#> 
#> $child[[27]]
#> [1] "http://id.who.int/icd/entity/2143513892"
#> 
#> 
#> $browserUrl
#> [1] "https://icd.who.int/browse/2026-01/foundation/en#1435254666"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "Certain infectious or parasitic diseases"
#> 
#> 
#> $synonym
#> $synonym[[1]]
#> $synonym[[1]]$label
#> $synonym[[1]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[1]]$label$`@value`
#> [1] "infection NOS"
#> 
#> 
#> 
#> $synonym[[2]]
#> $synonym[[2]]$label
#> $synonym[[2]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[2]]$label$`@value`
#> [1] "infection by unspecified organism and of unspecified site"
#> 
#> 
#> 
#> $synonym[[3]]
#> $synonym[[3]]$label
#> $synonym[[3]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[3]]$label$`@value`
#> [1] "infection process NOS"
#> 
#> 
#> 
#> $synonym[[4]]
#> $synonym[[4]]$label
#> $synonym[[4]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[4]]$label$`@value`
#> [1] "infection unknown"
#> 
#> 
#> 
#> $synonym[[5]]
#> $synonym[[5]]$label
#> $synonym[[5]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[5]]$label$`@value`
#> [1] "infectious disease NOS"
#> 
#> 
#> 
#> 
#> $definition
#> $definition$`@language`
#> [1] "en"
#> 
#> $definition$`@value`
#> [1] "This chapter includes certain conditions caused by pathogenic organisms or microorganisms, such as bacteria, viruses, parasites or fungi."
#> 
#> 
#> $exclusion
#> $exclusion[[1]]
#> $exclusion[[1]]$label
#> $exclusion[[1]]$label$`@language`
#> [1] "en"
#> 
#> $exclusion[[1]]$label$`@value`
#> [1] "Infection arising from device, implant or graft, not elsewhere classified"
#> 
#> 
#> $exclusion[[1]]$foundationReference
#> [1] "http://id.who.int/icd/entity/1612485599"
#> 
#> 
#> 
  icd_get_entity(id = "588616678")      ## block; depth 1
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForFoundationEntity.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/entity/588616678"
#> 
#> $parent
#> $parent[[1]]
#> [1] "http://id.who.int/icd/entity/1435254666"
#> 
#> 
#> $child
#> $child[[1]]
#> [1] "http://id.who.int/icd/entity/135352227"
#> 
#> $child[[2]]
#> [1] "http://id.who.int/icd/entity/1834648119"
#> 
#> $child[[3]]
#> [1] "http://id.who.int/icd/entity/30738976"
#> 
#> $child[[4]]
#> [1] "http://id.who.int/icd/entity/730271848"
#> 
#> $child[[5]]
#> [1] "http://id.who.int/icd/entity/2092703582"
#> 
#> $child[[6]]
#> [1] "http://id.who.int/icd/entity/1688127370"
#> 
#> 
#> $browserUrl
#> [1] "https://icd.who.int/browse/2026-01/foundation/en#588616678"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "Gastroenteritis or colitis of infectious origin"
#> 
#> 
  icd_get_entity(id = "1465325727")     ## category; depth 1
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForFoundationEntity.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/entity/1465325727"
#> 
#> $parent
#> $parent[[1]]
#> [1] "http://id.who.int/icd/entity/30738976"
#> 
#> 
#> $browserUrl
#> [1] "https://icd.who.int/browse/2026-01/foundation/en#1465325727"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "Enteritis due to Norovirus"
#> 
#> 
#> $synonym
#> $synonym[[1]]
#> $synonym[[1]]$label
#> $synonym[[1]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[1]]$label$`@value`
#> [1] "Noroviral enteritis"
#> 
#> 
#> 
#> $synonym[[2]]
#> $synonym[[2]]$label
#> $synonym[[2]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[2]]$label$`@value`
#> [1] "acute gastroenteropathy due to Norwalk agent"
#> 
#> 
#> 
#> $synonym[[3]]
#> $synonym[[3]]$label
#> $synonym[[3]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[3]]$label$`@value`
#> [1] "epidemic nausea"
#> 
#> 
#> 
#> $synonym[[4]]
#> $synonym[[4]]$label
#> $synonym[[4]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[4]]$label$`@value`
#> [1] "epidemic viral gastroenteritis due to Norwalk virus"
#> 
#> 
#> 
#> $synonym[[5]]
#> $synonym[[5]]$label
#> $synonym[[5]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[5]]$label$`@value`
#> [1] "epidemic vomiting"
#> 
#> 
#> 
#> $synonym[[6]]
#> $synonym[[6]]$label
#> $synonym[[6]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[6]]$label$`@value`
#> [1] "epidemic vomiting syndrome"
#> 
#> 
#> 
#> $synonym[[7]]
#> $synonym[[7]]$label
#> $synonym[[7]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[7]]$label$`@value`
#> [1] "epidemic winter vomiting disease"
#> 
#> 
#> 
#> $synonym[[8]]
#> $synonym[[8]]$label
#> $synonym[[8]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[8]]$label$`@value`
#> [1] "small round structured virus enteritis"
#> 
#> 
#> 
#> $synonym[[9]]
#> $synonym[[9]]$label
#> $synonym[[9]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[9]]$label$`@value`
#> [1] "viral gastroenteritis due to Norwalk agent"
#> 
#> 
#> 
#> $synonym[[10]]
#> $synonym[[10]]$label
#> $synonym[[10]]$label$`@language`
#> [1] "en"
#> 
#> $synonym[[10]]$label$`@value`
#> [1] "winter vomiting"
#> 
#> 
#> 
#> 
#> $definition
#> $definition$`@language`
#> [1] "en"
#> 
#> $definition$`@value`
#> [1] "A disease of the gastrointestinal tract, caused by an infection with norovirus. This disease is characterised by acute onset of vomiting, non-haemorrhagic diarrhoea, and abdominal pain. Transmission is by ingestion of contaminated food or water, direct contact, or through fomites. Confirmation is by identification of norovirus."
#> 
#> 
#> $longDefinition
#> $longDefinition$`@language`
#> [1] "en"
#> 
#> $longDefinition$`@value`
#> [1] "The official genus name Noroviruses which is the group of viruses previously described as “Norwalk-like viruses” are a group of related, single-stranded RNA, non-enveloped viruses. Noroviruses cause self-limiting explosive acute gastroenteritis that last for 24-48hours in humans. The most common symptoms of acute gastroenteritis are diarrhea, vomiting, and stomach pain."
#> 
#> 
#> $relatedEntitiesInPerinatalChapter
#> $relatedEntitiesInPerinatalChapter[[1]]
#> [1] "http://id.who.int/icd/entity/911707612"
#> 
#> 
  icd_get_info()
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForMultiVersion.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/11/mms"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "ICD-11 for Mortality and Morbidity Statistics"
#> 
#> 
#> $latestRelease
#> [1] "http://id.who.int/icd/release/11/2026-01/mms"
#> 
#> $release
#> $release[[1]]
#> [1] "http://id.who.int/icd/release/11/2026-01/mms"
#> 
#> $release[[2]]
#> [1] "http://id.who.int/icd/release/11/2025-01/mms"
#> 
#> $release[[3]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms"
#> 
#> $release[[4]]
#> [1] "http://id.who.int/icd/release/11/2023-01/mms"
#> 
#> $release[[5]]
#> [1] "http://id.who.int/icd/release/11/2022-02/mms"
#> 
#> $release[[6]]
#> [1] "http://id.who.int/icd/release/11/2021-05/mms"
#> 
#> $release[[7]]
#> [1] "http://id.who.int/icd/release/11/2020-09/mms"
#> 
#> $release[[8]]
#> [1] "http://id.who.int/icd/release/11/2019-04/mms"
#> 
#> $release[[9]]
#> [1] "http://id.who.int/icd/release/11/2018/mms"
#> 
#> 
  icd_get_info("icf")
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForMultiVersion.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/11/icf"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "International Classification of Functioning, Disability and Health (ICF)"
#> 
#> 
#> $latestRelease
#> [1] "http://id.who.int/icd/release/11/2026-01/icf"
#> 
#> $release
#> $release[[1]]
#> [1] "http://id.who.int/icd/release/11/2026-01/icf"
#> 
#> $release[[2]]
#> [1] "http://id.who.int/icd/release/11/2025-01/icf"
#> 
#> $release[[3]]
#> [1] "http://id.who.int/icd/release/11/2024-01/icf"
#> 
#> 
  icd_get_chapter()
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForTopLevel.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/11/2024-01/mms"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "ICD-11 for Mortality and Morbidity Statistics"
#> 
#> 
#> $releaseId
#> [1] "2024-01"
#> 
#> $releaseDate
#> [1] "2024-01-21"
#> 
#> $availableLanguages
#> $availableLanguages[[1]]
#> [1] "ar"
#> 
#> $availableLanguages[[2]]
#> [1] "cs"
#> 
#> $availableLanguages[[3]]
#> [1] "en"
#> 
#> $availableLanguages[[4]]
#> [1] "es"
#> 
#> $availableLanguages[[5]]
#> [1] "fr"
#> 
#> $availableLanguages[[6]]
#> [1] "pt"
#> 
#> $availableLanguages[[7]]
#> [1] "ru"
#> 
#> $availableLanguages[[8]]
#> [1] "tr"
#> 
#> $availableLanguages[[9]]
#> [1] "uz"
#> 
#> $availableLanguages[[10]]
#> [1] "zh"
#> 
#> 
#> $child
#> $child[[1]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1435254666"
#> 
#> $child[[2]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1630407678"
#> 
#> $child[[3]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1766440644"
#> 
#> $child[[4]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1954798891"
#> 
#> $child[[5]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/21500692"
#> 
#> $child[[6]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/334423054"
#> 
#> $child[[7]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/274880002"
#> 
#> $child[[8]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1296093776"
#> 
#> $child[[9]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/868865918"
#> 
#> $child[[10]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1218729044"
#> 
#> $child[[11]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/426429380"
#> 
#> $child[[12]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/197934298"
#> 
#> $child[[13]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1256772020"
#> 
#> $child[[14]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1639304259"
#> 
#> $child[[15]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1473673350"
#> 
#> $child[[16]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/30659757"
#> 
#> $child[[17]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/577470983"
#> 
#> $child[[18]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/714000734"
#> 
#> $child[[19]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1306203631"
#> 
#> $child[[20]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/223744320"
#> 
#> $child[[21]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1843895818"
#> 
#> $child[[22]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/435227771"
#> 
#> $child[[23]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/850137482"
#> 
#> $child[[24]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1249056269"
#> 
#> $child[[25]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/1596590595"
#> 
#> $child[[26]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/718687701"
#> 
#> $child[[27]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/231358748"
#> 
#> $child[[28]]
#> [1] "http://id.who.int/icd/release/11/2024-01/mms/979408586"
#> 
#> 
#> $browserUrl
#> [1] "https://icd.who.int/browse/2024-01/mms/en"
#> 
  icd_get_chapter("icf")
#> Release `2024-01` matches a known release for ICD-11.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForTopLevel.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/11/2024-01/icf"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "International Classification of Functioning, Disability and Health (ICF)"
#> 
#> 
#> $releaseId
#> [1] "2024-01"
#> 
#> $releaseDate
#> [1] "2024-01-21"
#> 
#> $availableLanguages
#> $availableLanguages[[1]]
#> [1] "ar"
#> 
#> $availableLanguages[[2]]
#> [1] "cs"
#> 
#> $availableLanguages[[3]]
#> [1] "en"
#> 
#> $availableLanguages[[4]]
#> [1] "es"
#> 
#> $availableLanguages[[5]]
#> [1] "fr"
#> 
#> $availableLanguages[[6]]
#> [1] "pt"
#> 
#> $availableLanguages[[7]]
#> [1] "ru"
#> 
#> $availableLanguages[[8]]
#> [1] "tr"
#> 
#> $availableLanguages[[9]]
#> [1] "uz"
#> 
#> $availableLanguages[[10]]
#> [1] "zh"
#> 
#> 
#> $child
#> $child[[1]]
#> [1] "http://id.who.int/icd/release/11/2024-01/icf/619527855"
#> 
#> $child[[2]]
#> [1] "http://id.who.int/icd/release/11/2024-01/icf/423829389"
#> 
#> 
#> $browserUrl
#> [1] "https://icd.who.int/browse/2024-01/icf/en"
#> 
# }
```
