# Get available ICD-10 releases

Get available ICD-10 releases

## Usage

``` r
icd_10_get_releases(
  api_version = c("v2", "v1"),
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access"
)

icd_10_get_chapters(
  release = NULL,
  api_version = c("v2", "v1"),
  language = "en",
  verbose = TRUE,
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access"
)

icd_10_get_release_by_category(
  category,
  api_version = c("v2", "v1"),
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access"
)

icd_10_get_info(
  category,
  release = NULL,
  api_version = c("v2", "v1"),
  language = "en",
  verbose = TRUE,
  base_url = "https://id.who.int",
  client = icd_oauth_client(),
  scope = "icdapi_access"
)
```

## Arguments

- api_version:

  Version of the API. Possible values are `v1` or `v2`. For example, if
  you provide value v2, the API will respond in the format of the
  version 2 of the API. Default is `v2`.

- base_url:

  The base URL of the API. Default uses the WHO API server at
  https://id.who.int. If you are using a locally deployed server or
  hosting your own ICD API server, you should specify the URL of your
  instance here.

- client:

  The OAuth2 client produced through a call to
  [`icd_oauth_client()`](https://oxford-ihtm.io/codigo/reference/icd_authenticate.md).

- scope:

  Scopes to be requested from the resource owner. Default is
  *"icdapi_access"* as specified in the ICD API documentation.

- release:

  A string specifying the release version of ICD-10 to search from. If
  not specified, defaults to the latest release version. See the
  available versions with `icd_versions`.

- language:

  ICD-API is multi-lingual. By changing this header, you may make the
  API respond in different languages. Languages will be available as the
  translations of ICD-11 completes. The values are language codes such
  as en, es, zh, etc. Depending on the `release_id` specified, the
  available languages will vary. Default is English ("en"). Note that
  language support for ICD-10 is limited to English (`en`).

- verbose:

  Logical. Should non-warning and non-error messages be printed? Default
  is TRUE.

- category:

  ICD-10 category code or for blocks, the code range.

## Value

A list with information on specified ICD 10 parameters

## Examples

``` r
icd_10_get_releases()
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForMultiVersion.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/10"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "International Statistical Classification of Diseases and Related Health Problems 10th Revision (ICD-10)"
#> 
#> 
#> $latestRelease
#> [1] "http://id.who.int/icd/release/10/2019"
#> 
#> $release
#> $release[[1]]
#> [1] "http://id.who.int/icd/release/10/2019"
#> 
#> $release[[2]]
#> [1] "http://id.who.int/icd/release/10/2016"
#> 
#> $release[[3]]
#> [1] "http://id.who.int/icd/release/10/2010"
#> 
#> $release[[4]]
#> [1] "http://id.who.int/icd/release/10/2008"
#> 
#> 
icd_10_get_chapters()
#> Release `2019` matches a known release for ICD-10.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForTopLevel.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/10/2019"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "International Statistical Classification of Diseases and Related Health Problems 10th Revision (ICD-10) Version for 2019"
#> 
#> 
#> $releaseDate
#> [1] "2020-02-01"
#> 
#> $child
#> $child[[1]]
#> [1] "http://id.who.int/icd/release/10/2019/I"
#> 
#> $child[[2]]
#> [1] "http://id.who.int/icd/release/10/2019/II"
#> 
#> $child[[3]]
#> [1] "http://id.who.int/icd/release/10/2019/III"
#> 
#> $child[[4]]
#> [1] "http://id.who.int/icd/release/10/2019/IV"
#> 
#> $child[[5]]
#> [1] "http://id.who.int/icd/release/10/2019/V"
#> 
#> $child[[6]]
#> [1] "http://id.who.int/icd/release/10/2019/VI"
#> 
#> $child[[7]]
#> [1] "http://id.who.int/icd/release/10/2019/VII"
#> 
#> $child[[8]]
#> [1] "http://id.who.int/icd/release/10/2019/VIII"
#> 
#> $child[[9]]
#> [1] "http://id.who.int/icd/release/10/2019/IX"
#> 
#> $child[[10]]
#> [1] "http://id.who.int/icd/release/10/2019/X"
#> 
#> $child[[11]]
#> [1] "http://id.who.int/icd/release/10/2019/XI"
#> 
#> $child[[12]]
#> [1] "http://id.who.int/icd/release/10/2019/XII"
#> 
#> $child[[13]]
#> [1] "http://id.who.int/icd/release/10/2019/XIII"
#> 
#> $child[[14]]
#> [1] "http://id.who.int/icd/release/10/2019/XIV"
#> 
#> $child[[15]]
#> [1] "http://id.who.int/icd/release/10/2019/XV"
#> 
#> $child[[16]]
#> [1] "http://id.who.int/icd/release/10/2019/XVI"
#> 
#> $child[[17]]
#> [1] "http://id.who.int/icd/release/10/2019/XVII"
#> 
#> $child[[18]]
#> [1] "http://id.who.int/icd/release/10/2019/XVIII"
#> 
#> $child[[19]]
#> [1] "http://id.who.int/icd/release/10/2019/XIX"
#> 
#> $child[[20]]
#> [1] "http://id.who.int/icd/release/10/2019/XX"
#> 
#> $child[[21]]
#> [1] "http://id.who.int/icd/release/10/2019/XXI"
#> 
#> $child[[22]]
#> [1] "http://id.who.int/icd/release/10/2019/XXII"
#> 
#> 
#> $browserUrl
#> [1] "http://apps.who.int/classifications/icd10/browse/2019/en"
#> 
icd_10_get_release_by_category(category = "A00")
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForMultiVersion.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/10/A00"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "Cholera"
#> 
#> 
#> $latestRelease
#> [1] "http://id.who.int/icd/release/10/2019/A00"
#> 
#> $release
#> $release[[1]]
#> [1] "http://id.who.int/icd/release/10/2019/A00"
#> 
#> $release[[2]]
#> [1] "http://id.who.int/icd/release/10/2016/A00"
#> 
#> $release[[3]]
#> [1] "http://id.who.int/icd/release/10/2010/A00"
#> 
#> $release[[4]]
#> [1] "http://id.who.int/icd/release/10/2008/A00"
#> 
#> 
icd_10_get_release_by_category(category = "A00-A09")
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForMultiVersion.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/10/A00-A09"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "Intestinal infectious diseases"
#> 
#> 
#> $latestRelease
#> [1] "http://id.who.int/icd/release/10/2019/A00-A09"
#> 
#> $release
#> $release[[1]]
#> [1] "http://id.who.int/icd/release/10/2019/A00-A09"
#> 
#> $release[[2]]
#> [1] "http://id.who.int/icd/release/10/2016/A00-A09"
#> 
#> $release[[3]]
#> [1] "http://id.who.int/icd/release/10/2010/A00-A09"
#> 
#> $release[[4]]
#> [1] "http://id.who.int/icd/release/10/2008/A00-A09"
#> 
#> 
icd_10_get_info(category = "A00")
#> Release `2019` matches a known release for ICD-10.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForICD10Entity.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/10/2019/A00"
#> 
#> $parent
#> $parent[[1]]
#> [1] "http://id.who.int/icd/release/10/2019/A00-A09"
#> 
#> 
#> $child
#> $child[[1]]
#> [1] "http://id.who.int/icd/release/10/2019/A00.0"
#> 
#> $child[[2]]
#> [1] "http://id.who.int/icd/release/10/2019/A00.1"
#> 
#> $child[[3]]
#> [1] "http://id.who.int/icd/release/10/2019/A00.9"
#> 
#> 
#> $browserUrl
#> [1] "http://apps.who.int/classifications/icd10/browse/2019/en#/A00"
#> 
#> $code
#> [1] "A00"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "Cholera"
#> 
#> 
#> $classKind
#> [1] "category"
#> 
icd_10_get_info(category = "A00-A09")
#> Release `2019` matches a known release for ICD-10.
#> Language `en` is available for the release specified.
#> $`@context`
#> [1] "http://id.who.int/icd/contexts/contextForICD10Entity.json"
#> 
#> $`@id`
#> [1] "http://id.who.int/icd/release/10/2019/A00-A09"
#> 
#> $parent
#> $parent[[1]]
#> [1] "http://id.who.int/icd/release/10/2019/I"
#> 
#> 
#> $child
#> $child[[1]]
#> [1] "http://id.who.int/icd/release/10/2019/A00"
#> 
#> $child[[2]]
#> [1] "http://id.who.int/icd/release/10/2019/A01"
#> 
#> $child[[3]]
#> [1] "http://id.who.int/icd/release/10/2019/A02"
#> 
#> $child[[4]]
#> [1] "http://id.who.int/icd/release/10/2019/A03"
#> 
#> $child[[5]]
#> [1] "http://id.who.int/icd/release/10/2019/A04"
#> 
#> $child[[6]]
#> [1] "http://id.who.int/icd/release/10/2019/A05"
#> 
#> $child[[7]]
#> [1] "http://id.who.int/icd/release/10/2019/A06"
#> 
#> $child[[8]]
#> [1] "http://id.who.int/icd/release/10/2019/A07"
#> 
#> $child[[9]]
#> [1] "http://id.who.int/icd/release/10/2019/A08"
#> 
#> $child[[10]]
#> [1] "http://id.who.int/icd/release/10/2019/A09"
#> 
#> 
#> $browserUrl
#> [1] "http://apps.who.int/classifications/icd10/browse/2019/en#/A00-A09"
#> 
#> $code
#> [1] "A00-A09"
#> 
#> $title
#> $title$`@language`
#> [1] "en"
#> 
#> $title$`@value`
#> [1] "Intestinal infectious diseases"
#> 
#> 
#> $classKind
#> [1] "block"
#> 
```
