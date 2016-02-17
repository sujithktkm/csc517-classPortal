class MessagesController < ApplicationController
  def see_message
    @message = Message.where("student_id=? and course_id=?",session[:user_id],session[:courseid])
    @new_message = Message.new

  end

  def instructor_message_view

    @studentlist = Student.select('"users".*, "student_enrollments"."status", "student_enrollments"."grade"').joins(:student_enrollments).where('student_enrollments.status = :status AND student_enrollments.course_id = :courseid', :status => 'ENROLLED', :courseid => params[:course_id].to_i)
    session[:courseid] = params[:course_id]


  end

  def instructor_message_send
    @message = Message.where("instructor_id=? and course_id=? and student_id =?",session[:user_id],session[:courseid],params[:id])
    session[:message] = params[:id]
    @new_message = Message.new


  end

  def instructor_message_save

    @message = Message.new(message_params)
    @message.role="Instructor"
    @message.instructor_id=session[:user_id]
    @message.course_id= session[:courseid]
    @message.student_id= User.find(session[:message]).id
    if @message.save
      flash[:success] = "message sent"
      redirect_to root_path
    else
      flash[:success] = "message failed"
      redirect_to root_path
    end

  end
  def send_new_message
    @message = Message.new(message_params)
    @message.role="Student"
    @message.student_id=session[:user_id]
    @message.course_id= session[:courseid]
    @message.instructor_id= Course.find(session[:courseid]).instructor_id
    if @message.save
      flash[:success] = "message sent"
      redirect_to(:action => 'see_message')
    else
      flash[:success] = "message failed"
      redirect_to(:action => 'see_message')
    end

  end
  private
  def message_params
    params.require(:message).permit(:content)
  end
end
