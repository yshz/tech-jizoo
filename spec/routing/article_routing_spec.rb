require 'rails_helper'

describe ArticlesController do
  describe 'routing' do
    it '`#index`にルーティングされる' do
      expect(get('/')).to route_to('articles#index')
      expect(get('/articles')).not_to be_routable
    end

    describe '#show' do
      it '`#show`にルーティングされない' do
        expect(get('/articles/1')).not_to be_routable
      end

      it '`#show`にルーティングされる' do
        expect(get('/2014/01/01/test')).to route_to('articles#show',
          year: '2014', month: '01', day: '01', title: 'test')
        expect(get('/articles/1/')).not_to be_routable
      end
    end
  end
end
