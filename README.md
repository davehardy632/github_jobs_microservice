# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* End Points

| URL | VERB | BODY | HEADERS | PARAMS | RESPONSE |
|----------------------------|------|------|--------------------------------------------------------------------------------------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /api/v1/users | POST | N/A | first_name, last_name, email, password, password_confirmation | N/A | first_name, last_name, email, api_key |
| /api/v1/sessions | POST | N/A | email, password | N/A | first_name, last_name, email, api_key |
| /api/v1/listings | GET | N/A | keywords(required), location(required), radius(optional), salary(optional), page(optional) | N/A | ``` totalCount:`numJobs`, jobs:[ title:`job title`, location:`job location`, snippet:`brief description`, salary:`job salary or null`, source: `source listing URL`, type: `Full-time/Part-time...`, link: `Jooble Job description`, company: `Company of job poster`, updated: `timestamp of job update`, id: `Jooble DB reference` ] ``` |
| /api/v1/urban_area/details | GET | N/A | location | N/A | Categories:   Business Freedom, City Size, Climate, Cost Of living, Culture, Economy, Education, Healthcare, Housing, Internal(Human interest), Job Market, Language, Minorities, Internet Access, Outdoors, Pollution, Safety, Startups, Taxation, Traffic, Travel Connectivity, Venture Capital ``` data:[  { float_value: `score for given category`, id:`Category reference`, label: `Category description`, type: `Score data-type` } ] ``` |
| api/v1/urban_area/salaries | GET | N/A | location | N/A | ```[ {  job:{     id:`job id`,    title: `job title`  }  salary_percentiles: {    percentile_25,    percentile_50,    percentile_75,   }  } } ] ``` |
| /api/v1/urban_area/images | GET | N/A | location | N/A | ``` {   mobile: `mobile app image`,   web: `web app image`  } ``` |
| /api/v1/urban_area/scores | GET | N/A | location | N/A | ``` {   teleport_city_score: `total aggregate score`,   summary:`City Summary`,   categories:[     color:`color code of score for html/css`,     name: `category`     score_out_of_10:`Score out of 10 for category`   ] } ``` |
