require 'rails_helper'

RSpec.describe Article, :type => :model do
  let (:path) { "#{Rails.root}/spec/articles/2014-01-01-test.md" }

  describe '#create_articles' do
    before { Article.create_articles }

    it 'Articlesテーブルが作成される' do
      expect(Article.all).not_to be_empty
    end

    it '複数回実行しても記事の全件数が変わらない' do
      glob_paths_size = Dir.glob("#{Rails.root}/app/articles/*.md").size
      expect(Article.all.size).to eq(glob_paths_size)
      Article.create_articles
      expect(Article.all.size).to eq(glob_paths_size)
      Article.create_articles
      expect(Article.all.size).to eq(glob_paths_size)
    end
  end

  describe '#parse_article_title' do
    it 'MarkdownのH1要素(`# `で始まる行)を取得する' do
      title = Article.parse_article_title(path)
      expect(title).to eq('Article Title')
    end
  end

  describe '#parse_article_body' do
    it 'Markdownの内容全体を取得する' do
      body = Article.parse_article_body(path)
      expect(body).to match(/<h2>/)
    end
  end

  describe '#parse_article_name' do
    it '.mdを除いたファイル名を取得する' do
      name = Article.parse_article_name(path)
      expect(name).to eq('2014-01-01-test')
    end
  end

  describe '#parse_article_date' do
    it 'ファイル名から日付を取得する' do
      path = "#{Rails.root}/spec/articles/2014-01-01-test.md"
      date = Article.parse_article_date(path)
      expect(date).to eq(Date::new(2014, 1, 1))
    end
  end
end
