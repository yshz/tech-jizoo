require 'rails_helper'

describe ArticlesController do
  describe 'GET #index' do
    context 'データベースに記事データが入っている' do
      before do
        Article.create_articles
        get :index
      end

      it 'ステータスコードとして200を返す' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'indexテンプレートを描画する' do
        expect(response).to render_template(:index)
      end

      it '@articlesに、ActiveRecord::Relationのオブジェクトを格納する' do
        expect(assigns(:articles)).to be_kind_of(ActiveRecord::Relation)
        expect(assigns(:articles)).to eq(Article.all)
      end
    end
  end

  describe 'GET #show' do
    context 'データベースに記事データが入っている' do
      before do
        Article.create_articles
        @params = { year: '2014', month: '08', day: '11', slug: 'lorem-ipsum' }
      end

      it 'ステータスコード200を返す' do
        get :show, @params
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'showテンプレートを描画する' do
        get :show, @params
        expect(response).to render_template(:show)
      end

      it '@article に、リクエストした Article オブジェクトを格納する' do
        # get :show, @params
        # expect(assigns(:article)).to eq(Article)
      end
    end
  end
end
