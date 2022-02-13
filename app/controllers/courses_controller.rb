class CoursesController < ApplicationController

  before_action :authenticate_admin, except: [:index, :show, :mycourses]
  before_action :authenticate_user, only: [:mycourses]

  def index
    @courses = Course.where(status: "Publish").includes(:course_categories)
  end

  def show 
    @course = Course.friendly.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    category = Category.find(params[:course][:category].to_i)

    if @course.save
      @course.categories << category
      redirect_to admin_management_courses_path, notice: "課程已建立"
    else
      render :new, alert: "抱歉，似乎出了點錯誤，請重新嘗試"
    end
  end

  def edit
    @course = Course.friendly.find(params[:id])
  end

  def update
    @course = Course.friendly.find(params[:id])

    if @course.update(course_params)
      redirect_to course_path(@course), notice: "課程內容已更新"
    else
      render :edit, alert: "抱歉，似乎出了點錯誤，請重新嘗試"
    end
  end
  
  def destroy
    @course = Course.friendly.find(params[:id])

    if @course.destroy
      redirect_to admin_management_courses_path, notice: "課程#{@course.name}已刪除"
    else
      render :show, alert: "抱歉，似乎出了點錯誤，請重新嘗試"
    end
  end

  def manage
    @courses = current_user.courses
  end

  def mycourses; end

  private

  def course_params
    params.require(:course).permit(:name, :price, :currency,:validity_duration, :status, :introduction, :personalized_prefix)
  end

end
