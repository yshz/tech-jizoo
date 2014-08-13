require 'rails_helper'

describe ApplicationController do
  controller do
    def runtime_error
      raise
    end

    def not_found_error
      raise ActiveRecord::RecordNotFound
    end

    def routing_error
      raise ActionController::RoutingError, 'routing error'
    end
  end

  context 'ActiveRecord::RecordNotFound を raise したとき' do
    before do
      routes.draw { get 'not_found_error' => "anonymous#not_found_error" }
    end

    it "error404 を表示すること" do
      get :not_found_error
      expect(response).to render_template('errors/not_found')
    end
  end

  context 'ActionController::RoutingError を raise したとき' do
    before do
      routes.draw { get 'routing_error' => "anonymous#routing_error" }
    end

    it "error404 を表示すること" do
      get :routing_error
      expect(response).to render_template('errors/not_found')
    end
  end

  context "RuntimeErrorをraiseしたとき" do
    before do
      routes.draw { get 'runtime_error' => "anonymous#runtime_error" }
    end

    it "error500 を表示すること" do
      get :runtime_error
      expect(response).to render_template('errors/internal_server_error')
    end
  end
end
