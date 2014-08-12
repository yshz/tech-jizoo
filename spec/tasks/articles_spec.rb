require 'rails_helper'

describe 'articles:create' do
  include_context 'rake'

  it 'prerequisites should include "environment"' do
    expect(subject.prerequisites).to include('environment')
  end

  it 'create articles' do
    expect(Article).to receive(:create_articles)
    subject.invoke
  end
end
