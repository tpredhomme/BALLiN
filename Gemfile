ruby "2.3.3"
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

gem 'coffee-rails', '~> 4.2'

gem 'devise'
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'haml'
gem 'font-awesome-rails', '4.7.0.2', github: 'bokmann/font-awesome-rails'

gem 'rails_12factor', group: :production

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
