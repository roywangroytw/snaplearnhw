module ApiV0
  class Mycourse < Grape::API
    before { authenticate! }

    desc "Get all purchased courses"

    get '/mycourses' do

      courses = Course.joins(:orders).where('orders.user_id = ?', current_user.id)
      present courses, with: ApiV0::Entities::Mycourse
      
    end

    desc "Get all purchased courses by filters"

    # params do
    #   requires :status, type: String
    #   requires :course_types, type: String
    # end

    get '/mycourses/filter' do

      puts "=============="
      puts params[:data]
      puts params[:status]
      puts params[:course_types]
      puts "=============="

    end

  end
end