# README

This is a sample application for calculating CO2 emissions from sample data
To run the application locally

## Development

1. redis-server (stopping redis: redis-cli shutdown)
2. sidekiq -q default
3. bin/dev

### Setting up data locally

1. Install Ruby 3.3.5
2. Install Node > 20.9.0
3. run `bundle Install`
4. run `rails db:create`
5. run `rails db:migrate`
