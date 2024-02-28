source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '6.1.7.4', group: :development
gem 'spree', github: 'spree/spree', branch: 'main'
gem 'spree_backend', '4.6.0'
gem 'rails-controller-testing'

gemspec
