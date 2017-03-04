require_relative 'helper'
require 'rack/test'
require'json'

RSpec.describe 'AllowCorsRackMiddleware' do
  include Rack::Test::Methods
  let(:app) { AllowCorsRackMiddleware.new app_inside }
  let(:app_inside) { -> (env) { [201, app_headers, ['']] } }
  let(:app_headers) { { 'Some-Header' => 'Some value' } }

  describe 'for the real request' do
    let(:response) { post '/' }

    it 'maintains status code' do
      expect(response.status).to eq 201
    end

    it 'maintains app headers' do
      expect(response.headers).to include(app_headers)
    end

    it 'allows any origin' do
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
    end
  end

  describe 'no app given' do
    let(:app) { AllowCorsRackMiddleware.new }

    let(:response) do
      options '/', {}, {
        'HTTP_ACCESS_CONTROL_REQUEST_HEADERS' => 'Whatever-Header',
        'HTTP_ACCESS_CONTROL_REQUEST_METHOD' => 'DELETE'
      }
    end

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'allows any origin' do
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
    end

    it 'allows any headers' do
      expect(response.headers['Access-Control-Allow-Headers']).
        to eq('Whatever-Header')
    end

    it 'allows any verb' do
      expect(response.headers['Access-Control-Allow-Methods']).
        to eq('DELETE')
    end
  end
end
