# Slot Booking Backend API
## Overview
This is a simple backend API for a slot booking system. It allows users to find available time slots and book them for a specific date and duration.

## Prerequisites
* Ruby 2.6.5 or higher
* Rails 6.0.3 or higher
* PostgreSQL

## Installation

1. Clone this repository to your local machine:
`git clone https://github.com/[username]/slot_booking_backend.git
  `
2. Change into the project directory:
`cd slot_booking_backend
  `
3. Run bundle install to install dependencies:
`bundle install
  `
4. Create and setup the database:
`rails db:create
  rails db:migrate
`
5. Start the server:
`rails s -p 3001`
6. Run test cases:
`bundle exec rspec
  `
* The API will now be running on http://localhost:3001

## Usage
The API has the following endpoints:

### Find available slots
* Endpoint: `GET /api/v1/slots/new`
* Parameters:
  - _date_: date in YYYY-MM-DD format 
  - _duration_: duration in minutes
* Example: GET /api/v1/slots?date=2022-01-01&duration=30
### Book a slot
* Endpoint: POST /api/v1/slots/book
* Parameters:
  - _start_time_: start time of the slot in YYYY-MM-DD HH:MM:SS format
  - _end_time_: end time of the slot in YYYY-MM-DD HH:MM:SS format
* Example:
`{
  "start_time": "2022-01-01 09:00:00",
  "end_time": "2022-01-01 09:30:00"
  }
  `
## Todo
* Implement rake task to delete unused booked slots after passing x number of days.