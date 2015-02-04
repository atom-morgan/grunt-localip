require 'socket'

if ARGV[0].nil?
  filename = "Gruntfile.js"
else
  filename = ARGV[0]
end

def getIp
  ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  ip.ip_address
end

ipaddress = getIp

host = ""
f = File.open(filename, 'r+')
f.each_line do |line|
  if line.include? "var _host"
    host = line
  end
end
f.close

File.open(filename, "r+") do |file|
  file << File.read(filename).sub(host, "    var _host = \'" + ipaddress + "\';\n")
end

puts "Old host: " + host.strip
puts "New host: var _host = \'" + ipaddress + "\';" 
