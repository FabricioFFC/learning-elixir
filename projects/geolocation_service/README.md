<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
# GeolocationService
[![Elixir][Elixir-icon]][Elixir-url]
[![Phoenix][Phoenix-icon]][Phoenix-url]

This project has 3 modules:

* **GeolocationService**: Responsible to manage the geolocation and also the app entrypoint.
* **GeolocationServiceWeb**: Responsible to expose an API to fetch geolocation data.
* **ImportService**: Responsible to import data from CSV.

## Setup

To run the geolocation service app you will need to install on your machine:
  * [Docker Compose V2](https://docs.docker.com/compose/install/)

You will also need to create a `.env` file inside the project's folder:

```bash
  cp .env.sample .env
```

## Running the app locally

Run `docker compose up` and then `docker compose run --rm app mix do ecto.create, ecto.migrate`

To test if the application is working you can fetch a geolocation using an IP address as parameter:

```sh
curl --location --request GET 'http://localhost:4000/api/geolocations/192.168.0.1'
```

You can also import a csv using `iex` following the steps below:

1. Connect in the app container: `docker compose exec app sh`
2. Enter on iex: `iex -S mix`
3. Download a CSV file and import it: `ImportService.Producer.import([CSV_FILE])`

## Testing the app on Fly.io

This app available through Fly.io on https://geolocation-app.fly.dev.

You can test a scenario where the IP address existing using curl:

```sh
curl --location --request GET 'https://geolocation-app.fly.dev/api/geolocations/171.129.232.20'
```

Or using an IP address that doesn't exist:

```sh
curl --location --request GET 'https://geolocation-app.fly.dev/api/geolocations/192.168.0.1'
```

## Design

### Database

The database is minimum with a `geolocations` table with an unique index on `ip_address` column to avoid duplications.

### Application

I attempted to implement a cohesive and minimalistic design. With this in mind the following strategies and ideas were implemented:

* Maintain all components within the same project while structuring them into distinct modules to establish a clear separation of responsibilities. This approach not only enhances organization but also facilitates effortless extraction into a standalone application if needed in the future.
* Since the amount of data imported can be huged I tried to avoid memory problems. That's why I used `Stream` and also doing extra loops.

### Assumptions

* I assumed the country, country_code and city could be blank, since we could fetch this info based on the longitude and latitude in another moment.
* I've considered that an IP address must be unique and that it can be a IPV4/IPV6.

### Trade-offs

* Since I avoided to loop again in each entry, the database insert is happening per entry. So we don't have the benefits of using `insert_all`.

### Things that could be improved

* Persist the geolocation data within a transaction, ensuring that a failure in any individual geolocation entry results in the entire file import being rolled back, maintaining data integrity.
* Validate IP Address passed on the API endpoint.
* Document the API and the code.
* Configure CI and CD on Github actions.
* The `ImportService.Producer` has a lot of responsabilies (e.g. parsers data, read CSV and insert data). It would be beneficial to refactor this service by extracting some of these responsibilities. Moreover, implementing the Adapter pattern could enable the service to dynamically handle various data formats, such as CSV, XML, and more, making it more versatile and maintainable.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[Elixir-icon]: https://img.shields.io/badge/elixir-663399?style=for-the-badge&logo=elixir&logoColor=white
[Elixir-url]: https://elixir-lang.org
[Phoenix-icon]: https://img.shields.io/badge/phoenix-FF6D31?style=for-the-badge&logo=phoenix&logoColor=white
[Phoenix-url]: https://phoenixframework.org