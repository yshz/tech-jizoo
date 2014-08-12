require 'rails_helper'

feature '記事一覧の表示' do
  scenario '記事一覧を表示する' do
    Article.create_articles
    visit root_path

    expect(page).to have_css('li', text: 'Lorem ipsum')
  end
end

feature '記事詳細の表示' do
  scenario '記事詳細を表示する' do
    Article.create_articles
    visit root_path
    click_link 'Lorem ipsum'

    expect(page).to have_css('h1', text: 'Lorem ipsum')
  end
end
