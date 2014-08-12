namespace :articles do
  desc 'Create articles from markdown files'
  task create: :environment do
    Article.create_articles
  end
end
