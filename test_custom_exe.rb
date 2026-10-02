require "rubygems"
require "bundler/setup"
$LOAD_PATH.unshift("lib")
require "msfenv"
require "msf/core"
File.write("dummy.exe", "DUMMYEXE")
framework = Msf::Simple::Framework.create
payload = framework.payloads.create("cmd/windows/http/x64/custom_exe")
payload.datastore['EXE_PATH'] = "dummy.exe"
payload.datastore['FETCH_COMMAND'] = 'CURL'
out = payload.generate_complete
puts "FETCH COMMAND: #{out}"
srv_res = payload.instance_variable_get(:@srv_resources).first
puts "SERVED DATA: #{srv_res[:data]}"
