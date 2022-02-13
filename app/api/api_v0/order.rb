module ApiV0
  class Order < Grape::API
    before { authenticate! }

    desc "Buy a course"
    params do
      requires :id, type: String
      requires :payment_type, type: String
    end

    post "orders/new" do
      course = Course.friendly.find(params[:id])

      if course
        if current_user.can_buy_again?(course.id)
          if course.status != "Offshelf"

            order = current_user.orders.build(
              valid_until: Time.current + course.validity_duration.days,
              currency: course.currency,
              amount: course.price,
              payment_type: params[:payment_type],
              paytime: Time.current,
              course_id: course.id
            )
      
            if order.save
              status 201
              { status: "success", message: "Order has been made successfully" }
            else
              status 500
              { status: "not ok", message: "Something went wrong, please try again" }
            end
          else
            status 418
            { status: "not ok", message: "The course cannot be purchased because it's not published" }
          end
        else
          status 200
          { status: "not ok", message: "You have purchased this course, and it's still valid" }
        end
      else
        status 400
        { status: "not ok", message: "The course does not exist!" }
      end

    end

  end
end