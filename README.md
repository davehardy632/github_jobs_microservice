<h1>Listings and City Microservice is a backend api developed in Rails</h1>

  For a more informed job search, explore where to move based on your personal preferences.

  The application was built with the purpose of creating a job listing site, that allows a user to access information about the locations that are associated with the job listings. A user then has access to a variety of useful information about the location of the job. They can then make more informed decisions about relocating, and considering other options to aid in their job search.

<h2>The application consumes 2 api's.</h2>

  The first is Jooble, Jooble is a job listings api that returns listing based on 4 criteria. 1. Keywords: any keyword relating to jobs can be entered. 2. Location: this can be a city/state, or zip code. 3. Salary: this can range betweem 33500 - 200000. 4. Radius: this can be a distance within 0, 5, 10, 15, 25, and 50 miles from the desired location. 5. Page: By default Jooble will return 20 results per api call. Page 1 refers to the first 20 results, page 2 would return the second 20 results, and so on. 

  The second API being consumed is Teleport. Teleport offers a range of useful data that allows you to compare cities based on quality of life, cost of living, salaries and more. Listings and City Microservice takes these two api's with the goal of merging the functionality in the frontend. The endpoints below allow a user to access information about the nearest urban area of a given city.
  
  The endpoints listed below return the following information. 
    The urban_area endpoints aggregate and present all of the most useful statistics, scores, images, and details associated with major urban areas around the world.
    The city info endpoint was implemented so that a user can see very basic information about any given city, and is used as a reference point. When a user passes a city or location into any of the urban area endpoints, they will always return info about the closest urban area to that endpoint, so being able to see info about the original city is a logical piece of information to be made available to a user.
    The listings endpoint will return a response as explained above.
    The users endpoint is implemented for registration functionality, and the sessions endpoint is for user login.


To access the jooble api, register for an api key on their site and include it in your env variables in an application.yml file

This application uses ruby version 2.4.1

To set up the application

  - clone the repository
  - cd into the repository
  - run $ "bundle" from the command line
  - run $ ``rails g rspec install`` to set up your test suite
  - run $ ``rails db:create`` to create the database
  - run $ ``rails db:migrate`` to create a users table in the database
  - run $ ``rails s`` to spin up the server
  - to hit the endpoints append /api/v1/whatever endpoint you choose


| URL | VERB | BODY | HEADERS | PARAMS | RESPONSE |
|----------------------------|------|------|--------------------------------------------------------------------------------------------|--------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /api/v1/users | POST | N/A | first_name, last_name, email, password, password_confirmation | N/A | first_name, last_name, email, api_key |
| /api/v1/sessions | POST | N/A | email, password | N/A | first_name, last_name, email, api_key |
| /api/v1/listings | GET | N/A | keywords(required), location(required), radius(optional), salary(optional), page(optional) | N/A | ``` totalCount:`numJobs`, jobs:[ title:`job title`, location:`job location`, snippet:`brief description`, salary:`job salary or null`, source: `source listing URL`, type: `Full-time/Part-time...`, link: `Jooble Job description`, company: `Company of job poster`, updated: `timestamp of job update`, id: `Jooble DB reference` ] ``` |
| /api/v1/urban_area/details | GET | N/A | location | N/A | Categories:   Business Freedom, City Size, Climate, Cost Of living, Culture, Economy, Education, Healthcare, Housing, Internal(Human interest), Job Market, Language, Minorities, Internet Access, Outdoors, Pollution, Safety, Startups, Taxation, Traffic, Travel Connectivity, Venture Capital ``` data:[  { float_value: `score for given category`, id:`Category reference`, label: `Category description`, type: `Score data-type` } ] ``` |
| api/v1/urban_area/salaries | GET | N/A | location | N/A | ```[ {  job:{     id:`job id`,    title: `job title`  }  salary_percentiles: {    percentile_25,    percentile_50,    percentile_75,   }  } } ] ``` |
| /api/v1/urban_area/images | GET | N/A | location | N/A | ``` {   mobile: `mobile app image`,   web: `web app image`  } ``` |
| /api/v1/urban_area/scores | GET | N/A | location | N/A | ``` {   teleport_city_score: `total aggregate score`,   summary:`City Summary`,   categories:[     color:`color code of score for html/css`,     name: `category`     score_out_of_10:`Score out of 10 for category`   ] } ``` |
| /api/v1/city_info | GET | N/A | location | N/A | {,"full_name": "City, State, Country",,"population": number} |
