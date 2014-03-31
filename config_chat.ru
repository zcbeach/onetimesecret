# Onetime Rackup - Chat
#
# Usage:
#
#     $ bundle exec thin -e dev -R config_chat.ru -p 7144 start
#     $ tail -f /var/log/system.log

ENV['RACK_ENV'] ||= 'prod'
ENV['APP_ROOT'] = ::File.expand_path(::File.join(::File.dirname(__FILE__)))
$:.unshift(::File.join(ENV['APP_ROOT']))
$:.unshift(::File.join(ENV['APP_ROOT'], 'lib'))
$:.unshift(::File.join(ENV['APP_ROOT'], 'app'))


require 'onetime/chat'
require 'http_router'

routes = HttpRouter.new do
  add('/sse').to(OT::Chat::TimeController)
end

file_server = Rack::File.new(File.join(File.dirname(__FILE__), 'public'))

use AsyncRack::CommonLogger
run Rack::Cascade.new([file_server, routes])
