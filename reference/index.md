# Package index

## Description

- [`codigo-package`](https://oxford-ihtm.io/codigo/reference/codigo.md)
  [`codigo`](https://oxford-ihtm.io/codigo/reference/codigo.md) :
  Interface to the International Classification of Diseases (ICD) API

## Authentication

- [`icd_oauth_client()`](https://oxford-ihtm.io/codigo/reference/icd_authenticate.md)
  [`icd_authenticate()`](https://oxford-ihtm.io/codigo/reference/icd_authenticate.md)
  : OAuth2 authentication to ICD API

## Search

- [`icd_search_foundation()`](https://oxford-ihtm.io/codigo/reference/icd_search.md)
  [`icd_search()`](https://oxford-ihtm.io/codigo/reference/icd_search.md)
  : Search the foundation component or linearizations of the ICD-11

## Autocode

- [`icd_autocode_foundation()`](https://oxford-ihtm.io/codigo/reference/icd_autocode.md)
  [`icd_autocode()`](https://oxford-ihtm.io/codigo/reference/icd_autocode.md)
  : Autocode against the foundation component or linearizations of the
  ICD-11

## Get

- [`icd_get_foundation()`](https://oxford-ihtm.io/codigo/reference/icd_get_foundation.md)
  [`icd_get_foundation_entity()`](https://oxford-ihtm.io/codigo/reference/icd_get_foundation.md)
  : Get information on various ICD-11 foundation entities
- [`icd_get_info()`](https://oxford-ihtm.io/codigo/reference/icd_get.md)
  [`icd_get_chapter()`](https://oxford-ihtm.io/codigo/reference/icd_get.md)
  : Get information on various ICD-11 linearization entities

## Get ICD-10

- [`icd_10_get_releases()`](https://oxford-ihtm.io/codigo/reference/icd_10_get.md)
  [`icd_10_get_chapters()`](https://oxford-ihtm.io/codigo/reference/icd_10_get.md)
  [`icd_10_get_release_by_category()`](https://oxford-ihtm.io/codigo/reference/icd_10_get.md)
  [`icd_10_get_info()`](https://oxford-ihtm.io/codigo/reference/icd_10_get.md)
  : Get available ICD-10 releases

## Map between ICD versions

- [`icd_map()`](https://oxford-ihtm.io/codigo/reference/icd_map.md) :
  Map ICD codes between versions

## Structure

- [`icd_structure_foundation()`](https://oxford-ihtm.io/codigo/reference/icd_structure.md)
  [`icd_structure_search()`](https://oxford-ihtm.io/codigo/reference/icd_structure.md)
  [`icd_structure_autocode()`](https://oxford-ihtm.io/codigo/reference/icd_structure.md)
  [`icd_structure_entity()`](https://oxford-ihtm.io/codigo/reference/icd_structure.md)
  : Structure ICD list and ICD search outputs

## Checks

- [`icd_check_release()`](https://oxford-ihtm.io/codigo/reference/icd_check.md)
  [`icd_check_language()`](https://oxford-ihtm.io/codigo/reference/icd_check.md)
  : Checks for specified parameters supplied to search, autocode, and
  get functions

## Utilities

- [`icd_get_releases()`](https://oxford-ihtm.io/codigo/reference/icd_utils.md)
  [`icd_get_languages()`](https://oxford-ihtm.io/codigo/reference/icd_utils.md)
  [`icd_get_entities()`](https://oxford-ihtm.io/codigo/reference/icd_utils.md)
  : Utility functions for retrieving ICD parameters and definitions

## Supporting datasets

- [`icd_versions`](https://oxford-ihtm.io/codigo/reference/icd_versions.md)
  : Table of supported classifications and versions by the ICD API
- [`icd11_linearization_mms`](https://oxford-ihtm.io/codigo/reference/icd11_linearization_mms.md)
  : ICD-11 Mortality and Morbidity Linearization Outputs
- [`icd11_simple_table_mms`](https://oxford-ihtm.io/codigo/reference/icd11_simple_table_mms.md)
  : ICD-11 Mortality and Morbidity Simple Table Outputs
- [`ten_map_to_multiple_eleven`](https://oxford-ihtm.io/codigo/reference/ten_map_to_multiple_eleven.md)
  : ICD 10 code or categories mapped to multiple ICD 11 categories
- [`ten_map_to_one_eleven`](https://oxford-ihtm.io/codigo/reference/ten_map_to_one_eleven.md)
  : ICD 10 code or categories mapped to one ICD 11 category
- [`eleven_map_to_one_ten`](https://oxford-ihtm.io/codigo/reference/eleven_map_to_one_ten.md)
  : ICD 11 code or categories mapped to one ICD 10 category
