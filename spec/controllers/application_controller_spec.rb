require 'rails_helper'

describe ApplicationController do
  controller do
    def runtime_error
      raise
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
