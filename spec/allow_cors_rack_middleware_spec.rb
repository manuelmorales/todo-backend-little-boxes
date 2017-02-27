require_relative 'helper'
require 'rack/test'
require'json'

RSpec.describe 'AllowCorsRackMiddleware' do
  include Rack::Test::Methods
  let(:app) { AllowCorsRackMiddleware.new app_inside }
  let(:app_inside) { -> (env) { [201, headers, ['']] } }

  let(:headers) do
    {
      'Content-Type' => 'application/json',
    }
  end

  let(:response) { get '/' }

  it 'maintains status code' do
    expect(response.status).to eq 201
  end

  it 'add CORS headers' do
    expect(response.headers).to eq({
      'Content-Type' => 'application/json',
      'Content-Length' => '0',
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Allow-Headers' => 'Content-Type',
    })
  end

  describe 'no app given' do
    let(:app) { AllowCorsRackMiddleware.new }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns header Content-Type' do
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(response.headers['Access-Control-Allow-Headers']).to eq('Content-Type')
    end
  end
end
