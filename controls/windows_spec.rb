title 'sample section'

describe command('hostname') do
  its(:stdout) { should match /HOSTNAME/ }
end

describe file('c:/windows') do
  it { should be_directory }
  it { should_not be_readable }
end

describe command('tzutil /g') do
  its(:stdout) { should match /Eastern Standard Time/ }
end

describe windows_feature('notepad') do
  it{ should be_installed }
end

# We're not listening for unencrypted telnet connections...right?
describe port(23) do
  it { should_not be_listening }
end

# The firewall is up...right?
describe service('MpsSvc') do
  it { should be_running }
end

##### Start User Verifications #####
describe user('Administrator') do
  it { should exist }
  it { should its 'Administrators' }
end
##### End User Verifications #####

describe service('DNS Client') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe group('Guests') do
  it { should exist }
end


### Fail Case 

describe file('c:/temp/test.txt') do
  it { should be_file }
  it { should contain "some text" }
end


