require 'spec_helper'
require 'knickknacks'

describe 'Knickknacks module' do
  include Knickknacks

  it 'runs specs' do
    expect(true).to be_truthy
  end

  describe '#sanitize_url' do
    let(:http_url) { 'http://some-url.org/some/filthy/path?with=dirty&querystring=too' }
    let(:https_url) { 'https://some-url.org/some/filthy/path?with=dirty&querystring=too' }
    let(:protocol_url) { 'whatever://some-url.org/some/filthy/path?with=dirty&querystring=too' }
    let(:path) { '/some/dirty/path' }
    let(:path_plus) { '/some/dirty/path?first=dirty&second=clean' }
    let(:messy_path) { '/some/me/dirty-dirty/path?weird=me&dinner=meat&meet=at-home' }

    it 'strips a list of strings from a target url path' do
      expect(sanitize_url(path, ['dirty', 'immaterial']))
        .to eq('/some/***/path')
    end

    it 'strips a list of strings from a target url path and query string' do
      expect(sanitize_url(path_plus, ['dirty', 'immaterial']))
        .to eq('/some/***/path?first=***&second=clean')
    end

    it 'avoids stripping subsets of urls and query strings' do
      expect(sanitize_url(messy_path, ['dirty', 'me', 'meet']))
        .to eq('/some/***/dirty-dirty/path?weird=***&dinner=meat&***=at-home')
    end

    it 'maintains the protocol string in the result' do
      expect(sanitize_url(http_url, ['dirty', 'filthy', 'nothing-special']))
        .to eq('http://some-url.org/some/***/path?with=***&querystring=too')
      expect(sanitize_url(https_url, ['dirty', 'filthy', 'nothing-special']))
        .to eq('https://some-url.org/some/***/path?with=***&querystring=too')
      expect(sanitize_url(protocol_url, ['dirty', 'filthy', 'nothing-special']))
        .to eq('whatever://some-url.org/some/***/path?with=***&querystring=too')
    end
  end
end
