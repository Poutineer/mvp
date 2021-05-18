source("https://rubygems.org")
git_source(:github) {|repo| "https://github.com/#{repo}.git"}

ruby("2.6.2")

gem("rails", "5.2.3")

gem("rack-attack", "5.4.2")
gem("rack-authentication_bearer", "2.0.2")
gem("rack-cors", "1.0.2")
gem("rack-rewrite", "1.5.1")
gem("rack-timeout", "0.5.1")

gem("connection_pool", "2.2.2")
gem("pg", "1.1.4")
gem("mini_magick", "4.9.4")
gem("action_operation", "2.2.0")
gem("addressable", "2.6.0", :require => false)
gem("bootsnap", "1.4.4", :require => false)
gem("pundit", "2.1.0")
gem("secure_headers", "6.1.1", :require => false)
gem("smart_params", "2.4.0")
gem("highline", "2.0.1")
gem("down", "4.8.1", :require => "down/net_http")
gem("flipper", "0.16.2")
gem("draper", "3.1.0")

gem("puma", "4.3.8")
gem("puma_worker_killer", "0.1.1")
gem("redcarpet", "3.5.0")

gem("hiredis", "0.6.3")
gem("redis-rails", "5.0.2")
gem("redlock", "1.0.1")
gem("redis-objects", "1.4.3")

gem("devise", "4.7.1")
gem("devise-async", "1.0.0")
gem("devise-security", "0.14.3")
gem("omniauth", "1.9.0")

gem("sidekiq", "5.2.7")
gem("sidecloq", "0.4.7")
gem("sidekiq-unique-jobs", "6.0.13")

gem("active_record-pool", "2.0.0")
gem("activerecord-like", "2.2")
gem("activerecord-safer_migrations", "2.0.0")
gem("ar_after_transaction", "0.5.0")
gem("baby_squeel", "1.3.1")
gem("ransack", "2.1.1")
gem("migration_data", "0.3.1")
gem("money-rails", "1.13.2")
gem("groupdate", "4.1.2")
gem("gutentag", "2.5.2")
gem("kaminari", "1.1.1")
gem("goldiloader", "3.1.0")
gem("friendly_id", "5.2.5")
gem("flag_shih_tzu", "0.3.23")
gem("rein", "5.0.0")
gem("state_machines-activerecord", "0.6.0")
gem("strong_migrations", "0.4.1")
gem("geocoder", "1.5.1")

gem("paper_trail", "10.0.1")
gem("paper_trail-background", "1.0.2")

gem("pry-doc", "1.0.0")
gem("pry-rails", "0.3.9")

gem("jsonapi-realizer", "6.0.0.rc3")
gem("jsonapi-materializer", "1.0.0.rc6")

gem("google_places", "1.2.0")

group(:production) do
  # gem("newrelic_rpm", "6.0.0.351") # TODO: Replace with elastic-ruby-apm
end

group(:development, :test) do
  gem("listen", "3.1.5")
  gem("dotenv-rails", "2.7.5", :require => "dotenv/rails-now")
  gem("rspec-rails", "3.8.2")
  gem("factory_bot_rails", "5.0.2")
  gem("faker", "2.1.2")
  gem("pry-byebug", "3.7.0")
  gem("bullet", "6.0.2")
  gem("active_record_query_trace", "1.5.4")
end

group(:test) do
  gem("rspec-retry", "0.6.1")
  gem("rspec-collection_matchers", "1.1.3")
  gem("rspec-sidekiq", "3.0.3")
  gem("rspec_junit_formatter", "0.4.1", :require => ENV.key?("CI"))
  gem("timecop", "0.9.1")
  gem("database_cleaner", "1.7.0")
end

group(:development) do
  gem("brakeman", "4.6.1", :require => false)
  gem("bundler-audit", "0.6.1", :require => false)
  gem("flamegraph", "0.9.5", :require => false)
  gem("memory_profiler", "0.9.12", :require => false)
  gem("rack-mini-profiler", "1.0.1", :require => false)
  gem("ruby-prof", "1.0.0", :require => false)
  gem("stackprof", "0.2.12", :require => false)
  gem("rubocop", "0.63.1", :require => false)
  gem("rubocop-rspec", "1.32.0")
end
