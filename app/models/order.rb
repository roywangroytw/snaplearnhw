class Order < ApplicationRecord
  belongs_to :course
  belongs_to :user

  after_create :generate_order_number

  private

  def generate_order_number
    order_number = "SNAP#{Time.current.strftime("%Y%m%d")}" + "#{code_generator(7)}"
    update(order_number: order_number)
  end

  def code_generator(n = 7)
    all_chars = [*'A'..'Z', *'0'..'9']
    confused_chars = ['X', 'O', '0', 'B', 'P', 'M', 'N', 'D', 'T']

    (all_chars - confused_chars).sample(n).join
  end

end
