require 'rails_helper'

RSpec.describe BooksController, type: :controller do
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

    # context 'with duplicate long_link' do
    #   let(:long_link) { 'https://www.google.com' }
    #   let!(:short_link) { create(:short_link, long_link: long_link, user_id: 1) }
    #   let(:params) { { long_link: long_link, user_id: 1 } }
    #
    #   it 'returns a 201' do
    #     request
    #     expect(response).to have_http_status(:created)
    #   end
    #
    #   it 'does not create a short_link' do
    #     expect { request }.to change(ShortLink, :count).by(0)
    #   end
    #
    #   it 'returns payload' do
    #     request
    #     expect(JSON.parse(response.body))
    #         .to eq('long_link' => long_link, 'short_link' => "http://test.host/#{short_link.encoded_id}")
    #   end
    # end
   end
end
