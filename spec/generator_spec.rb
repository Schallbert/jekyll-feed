# frozen_string_literal: true

require "spec_helper"

RSpec.describe JekyllFeed::Generator do
  let(:config) do
    Jekyll.configuration(
        "source"      => source_dir,
        "destination" => dest_dir,
        "url"         => "http://example.org"
    )

  end
  let(:site)     { Jekyll::Site.new(config) }
  let(:generator) { described_class.new(site: site) }

  before do
    generator.instance_variable_set(:@site, site)
  end

  describe '#get_thumb_key' do
    subject { generator.send(:get_thumb_key) }

    context 'when thumb_path_key is not set' do
      before do
        site.config.delete('thumb_path_key')
      end

      it 'returns the default key' do
        expect(subject).to eq('image.path')
      end
    end

    context 'when thumb_path_key is custom' do
      before do
        site.config['thumb_path_key'] = "custom.image.path"
      end

      it 'returns the custom key' do
        expect(subject).to eq('custom.image.path')
      end
    end
  end
end
