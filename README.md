## APP
A very basic Rails 5 app I've assembled to get my future projects up and running quickly. 

### Customization and Setup

* Configure your `.env` as needed
* Change `module YourRailsApp` to your desired application name in `config/application.rb`
* `rake db:setup`
* `foreman start -f Procfile.dev`

Things to note: There's an existing db schema with devise, papertrail, pg-search, and an admin configured the way I like. There are no migrations, so delete `schema.rb` before running `db:setup` and you'll get an empty database. This repo will evolve as I go forward.

## Gems

### Frontend Gems
Rails 5
SLIM
Boostrap 3
Turbolinks

### Backend Gems
Devise
AASM
AWS
Draper

### Environment Specific Gems

#### Production/Stagin
New Relic
Exception Notification
Rails 12 Factor (Heroku)

#### Testing/Dev Gems
Rspec
Cucumber
Mailcatcher
VCR
Solano

## Rake Tasks

### Deploy

`rake deploy:production`
`rake deploy:production:quick`
`rake deploy:staging`
`rake deploy:staging:quick`

### Run

`foreman start -f Procfile.dev`
