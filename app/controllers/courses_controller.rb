class CoursesController < ApplicationController

  def index
    @courses = Course.all.includes(:course_categories)
  end
  def show; end
  def new
    @course = Course.new
  end
  def create
    @course = current_user.courses.build(course_params)
    category = Category.find(params[:course][:category].to_i)

    if @course.save
      @course.categories << category
      redirect_to courses_path, notice: "課程已建立"
    else
      render :new, alert: "抱歉，似乎出了點錯誤，請重新嘗試"
    end
  end
  def edit; end
  def update; end
  def destroy; end

  private

  def course_params
    params.require(:course).permit(:name, :price, :currency,:validity_duration, :status, :introduction, :personalized_prefix)
  end

end
