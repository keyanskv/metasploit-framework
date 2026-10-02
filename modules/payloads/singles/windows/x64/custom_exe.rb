# frozen_string_literal: true

##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

module MetasploitModule

  CachedSize = 0

  include Msf::Payload::Single
  include Msf::Payload::Windows

  def initialize(info = {})
    super(
      merge_info(
        info,
        'Name' => 'Windows x64 Custom Executable',
        'Description' => %q{
          Uses a custom Windows x64 executable as the payload. This payload can be used
          with fetch payloads to serve an arbitrary Windows executable.
        },
        'Author' => 'Metasploit',
        'License' => MSF_LICENSE,
        'Platform' => 'win',
        'Arch' => ARCH_X64,
        'Payload' => {
          'Payload' => ''
        }
      )
    )

    register_options(
      [
        OptPath.new('EXE_PATH', [true, 'The custom executable to use'])
      ]
    )
  end

  def generate(opts = {})
    datastore['EXE::Custom'] = datastore['EXE_PATH']
    File.binread(datastore['EXE_PATH'])
  end

  def generate_payload_exe(opts = {})
    opts[:code]
  end

end
