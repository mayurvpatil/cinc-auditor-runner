# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'sample section'

# you can also use plain tests
describe file('/tmp') do
  it { should be_directory }
end

describe file('/etc/passwd') do
  it { should be_file }
end


# you add controls here
control 'tmp-1.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Create /tmp directory'             # A human-readable title
  desc 'An optional description...'
  describe file('/tmp') do                  # The actual test
    it { should be_directory }
  end
end

=begin
# Check for daemon services
describe command('pgrep crond') do
  its('stdout') { should_not eq "" }
end

describe command('pgrep getty') do
  its('stdout') { should_not eq "" }
end
=end

services = YAML.load_file(File.join(File.dirname(__FILE__), '../files/services.yml'))
services["services"].each do |s|
  describe command('sudo systemctl show '+s+' --no-page | grep ActiveState | cut -d "=" -f2') do
    its('stdout') { should eq "active\n" }
  end
  describe command('sudo systemctl show '+s+' --no-page | grep LoadState | cut -d "=" -f2') do
    its('stdout') { should eq "loaded\n" }
  end
end