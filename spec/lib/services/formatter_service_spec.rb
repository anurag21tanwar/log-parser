# frozen_string_literal: true

require_relative '../../../spec/spec_helper'
require_relative '../../../lib/services/formatter_service'

RSpec.describe FormatterService::InputData do
  let(:input) { '/help_page/1 126.318.035.038' }

  subject { described_class.new(input).call }

  it 'should split input with whitespace' do
    expect(subject.size).to eq(2)
  end

  context 'when invalid input' do
    context 'no white space' do
      let(:input) { '/help_page/1126.318.035.038' }

      it 'should raise an exception' do
        expect do
          subject
        end.to raise_exception(Errors::InvalidFileInputLineData).with_message('Invalid input line data')
      end
    end

    context 'when invalid url path' do
      let(:input) { '\\\\/help_page/1 126.318.035.038' }

      it 'should raise an exception' do
        expect do
          subject
        end.to raise_exception(Errors::InvalidFileInputLineDataTypeUrl).with_message('Invalid input line data, url path incorrect')
      end
    end
  end
end

RSpec.describe FormatterService::OutputData do
  let(:data_hashmap) do
    { '/about' => %w[0.0.0.0 0.0.0.0 0.0.0.0],
      '/index' => %w[0.0.0.1 0.0.0.2] }
  end

  subject { described_class.new(data_hashmap) }

  it 'should print correct ordered data on std_out' do
    expect do
      subject.call
    end.to output("\"1) list of webpages with most page views ordered from most pages views to less page views:\"\n\"     * /about 3 visits\"\n\"     * /index 2 visits\"\n\"2) list of webpages with most unique page views also ordered:\"\n\"     * /index 2 unique views\"\n\"     * /about 1 unique views\"\n").to_stdout
  end

  describe 'private methods' do
    describe '#webpages_with_most_views' do
      it 'should return data_hashmap with most page views ordered most to less' do
        expect(subject.send(:webpages_with_most_views)).to eq([['/about', %w[0.0.0.0 0.0.0.0 0.0.0.0]],
                                                               ['/index', %w[0.0.0.1 0.0.0.2]]])
      end
    end

    describe '#webpages_with_most_uniq_views' do
      it 'should return data_hashmap with most uniq page views ordered most to less' do
        expect(subject.send(:webpages_with_most_uniq_views)).to eq([['/index', %w[0.0.0.1 0.0.0.2]],
                                                                    ['/about', %w[0.0.0.0 0.0.0.0 0.0.0.0]]])
      end
    end
  end
end
