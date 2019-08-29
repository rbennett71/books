require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  render_views
  describe 'GET #index' do
    context 'valid parameters' do
      let(:headers) { valid_headers }
      let(:user) { create(:user) }
      before {
        allow_any_instance_of(ApplicationController).to receive(:authorize_request).and_return(true)
        FactoryBot.create_list(:book, 80)
        get :index, params: {:format => 'json'}
      }
      it 'returns a 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns JSON' do
        expect(JSON.parse(response.body).first).to  eq({"id"=>81, "title"=>"SAMPLE BOOK", "isbn"=>"MDWX00081", "author_last_name"=>"Joyce"})
      end
    end
  end

  describe 'POST #create' do
    let (:request) {post :create, params: params}
    before {
      FactoryBot.create_list(:book, 80)
      allow_any_instance_of(described_class).to receive(:authorize_request).and_return(true)
    }

    context 'with valid params' do
      let(:user) { create(:user) }
      let(:headers) { valid_headers }
      let(:title) { 'The Sun Also Rises'}
      let(:isbn)  { '0385472579' }
      let(:params) { { title: title, isbn: isbn , author_last_name: 'Stein', format: 'json'} }


      it 'returns a 201' do
        request
        expect(response).to have_http_status(:created)
      end

      it 'returns payload' do
        request
        expect(JSON.parse(response.body).slice('title', 'isbn'))
            .to eq('title' => title, 'isbn' => isbn)
      end
    end

    context 'with missing title' do
      let(:user) { create(:user) }
      let(:headers) { valid_headers }
      let(:title) { 'The Sun Also Rises'}
      let(:isbn)  { '0385472579' }
      let(:params) { { isbn: isbn, format: 'json'} }

      it 'returns a 422' do
        # params.delete(:isbn)
        request
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq("title"=>["can't be blank"])
      end
    end

    context 'with duplicate isbn' do
      let(:user) { create(:user) }
      let(:headers) { valid_headers }
      let(:title) { 'The Sun Also Rises'}
      let(:isbn)  { "MDWX0001" }
      let(:params) { { isbn: Book.first.isbn, title: title ,format: 'json'} }

      it 'returns a duplicate message' do
        request
        expect(JSON.parse(response.body)).to eq("isbn"=>["has already been taken"])
      end
    end
  end
end
