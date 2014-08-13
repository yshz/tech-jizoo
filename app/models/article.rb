class Article < ActiveRecord::Base
  GLOB_PATH = "#{Rails.root}/app/articles/*.md"

  def self.create_articles
    before_ids = Article.pluck(:id)
    after_ids = []

    Dir.glob(GLOB_PATH).sort.each do |path|
      article = Article.where(file_name: parse_article_name(path)).first_or_create
      article.title = parse_article_title(path)
      article.body = parse_article_body(path)
      article.published_at = parse_article_date(path)
      article.save!

      after_ids << article.id
    end

    will_delete_ids = before_ids - after_ids
    Article.where(id: will_delete_ids).destroy_all
  end

  def self.parse_article_title(path)
    text = File.open(path).read
    index = text.lines.index { |v| v.match(/^#\s/) }
    text.lines[index].sub(/^#\s/, '').chomp
  end

  def self.parse_article_body(path)
    text = File.open(path).read
    index = text.lines.index { |v| v.match(/^#\s/) }.succ
    body_text = text.lines[index..-1].join
    Kramdown::Document.new(body_text, auto_ids: false).to_html.strip
  end

  def self.parse_article_name(path)
    File.basename(path, '.md')
  end

  def self.parse_article_date(path)
    md = /\/(20\d{2})-([01]\d)-([0-3]\d)-(.+)\.md/.match(path)
    Date.new(md[1].to_i, md[2].to_i, md[3].to_i)
  end
end
