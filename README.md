# Car Wash App
* [Heroku App](https://emilycritter-car-wash.herokuapp.com/)

## Objectives
* Your car wash accepts cars and trucks.
* You charge $5 for cars.
* You charge $10 for trucks.
* Your car wash charges $2 extra if the truck has mud in the bed.
* Your car wash does not accept trucks with the bed let down.
* If the vehicle comes in a second time, they get 50% off.
* If the license plate equals 1111111, the vehicle is stolen and does not get a car wash

## Assumptions
* The following assumptions were made based on this statement: "If the vehicle comes in a second time, they get 50% off."
  * 50% discount taken *after* any additional charges
  * Every other *paid* visit receives this discount
* License plates have a minimum length of 4 characters and a maximum length of 8 characters
* License plates contain only alphanumeric characters

## Requirements

* [Ruby 2.3.1](https://www.ruby-lang.org/en/downloads/)
* [Rails 4.2.6](http://rubyonrails.org/)
* [MySQL 5.7.19](https://dev.mysql.com/downloads/mysql/)

## Setup
1. To get started, you'll need to install the gems needed for the server and for development by running:
  * `bundle install`
2. You can create a local database by running the following:
  * `rake db:create`
  * `rake db:migrate`
  * `rake db:seed`
3. To run tests, use:
  * `rake spec`

## Usage
1. Start the server by running: `rails s`
2. Open up the home page: `http://localhost:3000`

## Room for improvement
* Add more tests
  * e.g. include controller tests
* Incorporate browser testing and responsive web design (in addition to what Bootstrap includes by default)
* Improve UI/UX
* Make list of transactions sortable by column
