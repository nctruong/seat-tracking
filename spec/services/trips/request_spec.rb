require 'rails_helper'

RSpec.describe Trips::Request do
  describe '#call' do
    context 'when portOriginCountry is "INDONESIA"' do
      it 'converts to SG time ATD by plussing 1 hour' do

      end
    end

    context 'when portOriginCountry is not "INDONESIA" (SINGAPORE)' do
      it 'converts to SG time ATA by plussing 1 hour' do

      end
    end
  end
end