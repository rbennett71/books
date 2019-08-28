require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  render_views
  describe 'GET #index' do
    let(:params) { {:format => 'json'} }
    let(:request) { get :index, params: params }

    it 'returns a 200' do
      FactoryBot.create_list(:book, 80)
      request
      expect(response).to have_http_status(:ok)
    end
    it 'returns JSON' do
      FactoryBot.create_list(:book, 3)
      request
      expect(JSON.parse(response.body).first).to  eq({"id"=>1, "title"=>"SAMPLE BOOK", "isbn"=>"MDWX0001"})
    end
  end


  describe 'POST #create' do
    let(:params) { {} }
    let(:request) { post :create, params: params }

    context 'with valid params' do
      let(:title) { 'The Sun Also Rises'}
      let(:isbn)  { '0385472579' }
      let(:params) { { title: title, isbn: isbn } }

      it 'returns a 201' do
        request
        expect(response).to have_http_status(:created)
      end

      it 'creates a book' do
        expect { request }.to change(Book, :count).by(1)
      end

      it 'returns payload' do
        request
        expect(JSON.parse(response.body))
            .to eq('long_link' => long_link, 'short_link' => "http://test.host/#{ShortLink.last.encoded_id}")
      end
    end
  end
end
