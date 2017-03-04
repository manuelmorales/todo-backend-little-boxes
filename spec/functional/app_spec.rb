require_relative '../helper'

RSpec.describe 'box.app' do
  describe '#start' do
    let(:box) { Box.new }
    let(:app) { box.app }

    it 'runs puma on the given port' do
      puma = double(:puma, run: true)
      puma_class = double(:puma_cli_class, new: puma)

      require 'puma/cli' # Has to be loaded before stubbing
      stub_const('Puma::CLI', puma_class)

      box.cfg[:port] = 80

      expect(puma_class).
        to receive(:new).
        with(['-p', '80']).
        and_return(puma)

      expect(puma).to receive(:run)

      app.start
    end
  end
end
