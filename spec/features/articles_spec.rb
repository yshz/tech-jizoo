require 'rails_helper'

feature '記事一覧の表示' do
  scenario '記事一覧を表示する' do
    Article.create_articles
    visit root_path

    expect(page).to have_title('jizoo blog')
    expect(page).to have_link('jizoo blog')
    expect(page).to have_css('h2', text: 'Lorem ipsum')
    expect(page).to have_css('li', text: 'Lorem ipsum')
    expect(page).to have_css('footer', text: 'jizoo')
  end
end

feature '記事詳細の表示' do
  scenario '記事詳細を表示する' do
    Article.create_articles
    visit root_path
    first('h2').click_link 'Lorem ipsum'

    expect(page).to have_title('jizoo blog - Lorem ipsum')
    expect(page).to have_css('h1', text: 'Lorem ipsum')
  end
end

feature '存在しないページにアクセスする' do
  scenario 'ステータスコード404が返る' do
    visit '/2014/01/01/invalid-url'
    expect(page.status_code).to eq(404)
    expect(page).to have_text('ページは見つかりません。')
    expect(page).to have_link('home', href: root_path)
  end
end
