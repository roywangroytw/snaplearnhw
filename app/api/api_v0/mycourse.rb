module ApiV0
  class Mycourse < Grape::API
    before { authenticate! }

    desc "Get all purchased courses"

    get '/mycourses' do

      courses = Course.joins(:orders).where('orders.user_id = ?', current_user.id)
      present courses, with: ApiV0::Entities::Mycourse
      
    end

    desc "Get all purchased courses by filters"

    params do
      requires :status, type: String
      requires :course_types, type: String
    end

    get '/mycourses/filter' do

      status = params[:status]
      course_types = params[:course_types].split(",").map(&:to_i) 
      user_id = current_user.id

      puts "================================"
      p course_types
      p status
      p status.kind_of?(String)
      p course_types.kind_of?(Array)
      puts "================================"

      if status == "" && course_types.length == 0
        status 200
        { status: "not ok", message: "At least one of the filter criteria has to be provided" }
      else
        courses = Course.filter_courses(status, course_types, user_id)
        present courses, with: ApiV0::Entities::Mycourse
      end

    end

  end
end