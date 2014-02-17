require 'timeout'
require 'socket'

namespace :servers do
  desc "TODO"
  task uptime_check: :environment do
    @servers = Server.all
    
    @servers.each do |server|
      begin
        Timeout.timeout(2) do
          s = TCPSocket.new(server.ip.split(':')[0], 'echo')
          s.close
          server.uptime_checks << UptimeCheck.create(server: server, up: true)
        end
      rescue Errno::ECONNREFUSED
        server.uptime_checks << UptimeCheck.create(server: server, up: true)
      rescue Timeout::Error, Errno::ENETUNREACH, Errno::EHOSTUNREACH
        server.uptime_checks << UptimeCheck.create(server: server, up: false)
      end
    end
  end

end
