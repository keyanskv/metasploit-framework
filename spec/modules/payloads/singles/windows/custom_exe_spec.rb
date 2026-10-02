require 'spec_helper'

RSpec.describe 'windows/custom_exe' do
  let(:subject) do
    Msf::Simple::Framework.create.payloads.create('windows/custom_exe')
  end

  let(:dummy_exe_path) do
    path = File.join(Dir.tmpdir, 'dummy_custom.exe')
    File.binwrite(path, "MZ\x90\x00\x03\x00\x00\x00")
    path
  end

  after(:each) do
    File.delete(dummy_exe_path) if File.exist?(dummy_exe_path)
  end

  it 'generates a payload containing the exact contents of EXE_PATH' do
    subject.datastore['EXE_PATH'] = dummy_exe_path
    expect(subject.generate).to eq("MZ\x90\x00\x03\x00\x00\x00")
  end

  it 'bypasses generate_payload_exe by returning the exact raw file' do
    subject.datastore['EXE_PATH'] = dummy_exe_path
    opts = { code: subject.generate }
    expect(subject.generate_payload_exe(opts)).to eq("MZ\x90\x00\x03\x00\x00\x00")
  end
end
