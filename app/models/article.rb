class Article < ActiveRecord::Base
  GLOB_PATH = "#{Rails.root}/app/articles/*.md"

  def self.create_articles
    Dir.glob(GLOB_PATH).sort.each do |path|
      article = Article.create
      article.title = parse_article_title(path)
      article.body = parse_article_body(path)
      article.file_name = parse_article_name(path)
      article.published_at = parse_article_date(path)
      article.save
      article
    end
  end

  def self.parse_article_title(path)
    text = File.open(path).read
    index = text.lines.index { |v| v.match(/^#\s/) }
    text.lines[index].sub(/^#\s/, '').chomp
  end

  def self.parse_article_body(path)
    text = File.open(path).read
    Kramdown::Document.new(text, auto_ids: false).to_html
  end

  def self.parse_article_name(path)
    File.basename(path, '.md')
  end

  def self.parse_article_date(path)
    md = /\/(20\d{2})-([01]\d)-([0-3]\d)-(.+)\.md/.match(path)
    Date.new(md[1].to_i, md[2].to_i, md[3].to_i)
  end
end
