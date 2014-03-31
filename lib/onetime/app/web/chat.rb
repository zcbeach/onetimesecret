
module Onetime
  class App

    class Chat
      include Base
      def index
        publically do
          view = Onetime::App::Views::Chat::Index.new req, sess, cust
          res.body = view.render
        end
      end
    end

  end
end
