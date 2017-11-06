# Readme for Rails-Template

## Description
This repository contains a quickstart template for a new rails app using the postgresql database, and rspec testing framework

## Quickstart guide

$`git clone https://github.com/shirlaine/rails-template.git`

$`cd rails-template`

$`bundle install`

## Database Setup
- `$ bin/rake db:create`

## Integration Test Setup
- under .circleci/config.yml, replace `rails-template` with `your-app-name`

## Gem List
- Development:
  - Bootstrap
  - Jquery-Rails
  - Simple_form
  - Rubocop
  - Faker
  - Devise

- Test:
  - Rspec-rails
  - Shoulda-Matchers
  - Factory_bot_rails
  - Rails-controller-testing
