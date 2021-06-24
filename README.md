# README

This app is currently deployed in Heroku. There are no visitable urls.

## Implementation Notes

- This app was developed using `rbenv`-managed `ruby 2.6.7`
- Given the features being asked of for this Coding Challenge, I've decided that
  it is sensical to not save unused properties from EF `Listing` resource.
- The `Listing` model uses very little validation in order to be as accepting
  as possible to the incoming Empire Flippers API response data
- The `listings` table uses `uuid` as primary key since I've noticed that EF's
  `Listing` resource uses `uuid` as `id`
- After downloading 1739 EF `Listing` resources, I was sure that an `id`
  corresponds to only one `listing_number`. With this knowledge in mind, I made
  the decision to trust the reliability of my `Listing#x__is_in_hubspot` in
  ensuring that a Hubspot `Deal` is not duplicated.

## Dependencies

- Ruby version: `2.6.7`
- System dependencies:
  - ruby
  - postgresql (with postgresql-contrib for `uuid`-generation support)
  - redis

## Development Environment Setup

- run `bin/setup` from inside the project directory
  - if the database cannot be created, either configure `config/database.yml` to
    use your postgresql credentials OR configure your postgresql installation to
    work with the current `config/database.yml`
- run `bin/rails credentials:edit --environment development` to edit ensure that
  development env will work properly
  - you need to set `secret_key_base`
  - you need to set `hubspot[:hapikey]`
- run `bin/rspec` to execute the test suite

## Production Environment Setup

- install [heroku-cli](https://devcenter.heroku.com/articles/heroku-cli#download-and-install)
- run `heroku login` from the terminal
  - make a Heroku account if you do not have one
- configure your ssh keys from inside your Heroku account
- run `heroku create` from inside the project directory
- run `git push heroku master`
- run `heroku ps:scale worker=1`
- run `heroku run rails db:migrate`
- do not forget to set your `RAILS_MASTER_KEY`, so that Hubspot API will
  properly work

## License

This app was developed by Emmanuel Natividad.
Copyright © 2021, Emmanuel Natividad
