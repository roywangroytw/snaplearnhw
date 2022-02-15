module ApiV0
  module Entities
    class Mycourse < Entities::Base
      expose :name
      expose :introduction
      expose :slug
      expose :orders do
        expose :order_number
        expose :currency
        expose :amount
        expose :payment_type
        expose :paytime
        expose :valid_until
      end
    end
  end
end