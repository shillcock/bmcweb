web: bundle exec passenger start -p $PORT --max-pool-size 3
redis: redis-server /usr/local/etc/redis.conf
worker: bundle exec sidekiq
