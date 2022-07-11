# frozen_string_literal: true

require_relative '../../../spec/spec_helper'
require_relative '../../../lib/services/process_log_service'
require 'byebug'

RSpec.describe ProcessLogService do
  let(:data_hashmap) { {} }
  let(:input) { '/help_page/1 126.318.035.038' }

  subject { described_class.new(data_hashmap, input) }

  it 'should add new key value to data hashmap' do
    subject.call
    expect(data_hashmap.key?('/help_page/1')).to be(true)
  end

  context 'when data_hashmap has key' do
    let(:data_hashmap) { { '/help_page/1' => ['126.318.035.038'] } }

    it 'should update existing key to data hashmap' do
      subject.call
      expect(data_hashmap['/help_page/1'].length).to be(2)
    end
  end

  context 'when invalid input' do
    let(:input) { '/help_page/1126.318.035.038' }

    it 'should print an error message to std_out' do
      expect do
        subject.call
      end.to raise_exception(Errors::InvalidFileInputLineData).with_message('Invalid input line data')
    end
  end
end
