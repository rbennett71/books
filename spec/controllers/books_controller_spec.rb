require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  render_views
  describe 'GET #index' do
    let(:params) { {:format => 'json'} }
    let(:headers) { valid_headers }
    let(:user) { create(:user) }

    context 'valid parameters' do
      before {
        allow_any_instance_of(ApplicationController).to receive(:authorize_request).and_return(true)
        FactoryBot.create_list(:book, 80)
        get :index, params: {:format => 'json'}
      }
      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns JSON' do
        expect(JSON.parse(response.body).first).to  eq({"id"=>81, "title"=>"SAMPLE BOOK", "isbn"=>"MDWX00081"})
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:headers) { valid_headers }

    before {
      FactoryBot.create_list(:book, 80)
      allow_any_instance_of(described_class).to receive(:authorize_request).and_return(true)

      post :create, params: { title: title, isbn: isbn, :format => 'json' }
    }

    context 'with valid params' do
      let(:title) { 'The Sun Also Rises'}
      let(:isbn)  { '0385472579' }

      it 'returns a 201' do
        expect(response).to have_http_status(:created)
      end

      it 'returns payload' do
        expect(JSON.parse(response.body)['extract'].slice('title', 'isbn'))
            .to eq('title' => title, 'isbn' => isbn)
      end
    end
  end
end
