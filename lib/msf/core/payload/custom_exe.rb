# frozen_string_literal: true

module Msf::Payload::CustomExe
  def initialize(info = {})
    super
    register_options(
      [
        Msf::OptPath.new('EXE_PATH', [true, 'The custom executable to use'])
      ]
    )
  end

  def generate(opts = {})
    File.binread(datastore['EXE_PATH'])
  end

  def generate_payload_exe(opts = {})
    opts[:code]
  end
end
