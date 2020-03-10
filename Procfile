web: bundle exec rails server -p $PORT
release: bundle exec rails db:migrate seed:initial
worker: bundle exec sidekiq -C config/sidekiq.yml # remember: `heroku ps:scale worker=1`
