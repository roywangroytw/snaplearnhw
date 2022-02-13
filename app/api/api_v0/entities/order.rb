module ApiV0
  module Entities
    class Order < Entities::Base
      expose :order_number
      expose :currency
      expose :amount
      expose :payment_type
      expose :paytime
      expose :valid_until
    end
  end
end