module ApiV0
  module Entities
    class Mycourse < Entities::Base
      expose :name
      expose :introduction
      expose :slug
      expose :orders, using: ApiV0::Entities::Order
    end
  end
end