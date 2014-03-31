
require 'onetime'  # must be required before

require 'timeout'
require 'cramp'
require 'async_rack'


class Onetime::Chat

  class TimeController < Cramp::Action
    self.transport = :sse

    on_start :send_latest_time
    periodic_timer :send_latest_time, :every => 2

    def send_latest_time
      data = {'time' => Time.now.to_i}.to_json

      # render data, :retry => 10
      render data
    end
  end

end
