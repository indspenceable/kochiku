require 'spec_helper'

describe RemoteServer::Stash do
  describe '.project_params' do
    it 'parses HTTPS url' do
      result = described_class.project_params \
        "https://stash.example.com/scm/myproject/myrepo.git"

      expect(result).to eq(
        host:       'stash.example.com',
        username:   'myproject',
        repository: 'myrepo'
      )
    end

    it 'does not support HTTP auth credentials in URL' do
      # Use a netrc file instead.
      expect { described_class.project_params \
        "https://don@stash.example.com/scm/myproject/myrepo.git"
      }.to raise_error(UnknownUrl)
    end

    it 'does not support git URLs' do
      # This is current behaviour, though if you want to add support for it
      # that would be cool.
      expect { described_class.project_params \
        "ssh://git@stash.example.com:7999/myproject/myrepo.git"
      }.to raise_error(UnknownUrl)
    end
  end
end
