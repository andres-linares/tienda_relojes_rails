web: bundle exec rails server -p $PORT
worker: bundle exec sidekiq -C config/sidekiq.yml # remember: `heroku ps:scale worker=1`
