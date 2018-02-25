class AlarmsController < ApplicationController
	def new
	end

	def create
		alarm_msg = Alarm.create message: create_alarm_params[:message], user_id: current_user.id
		UserMailer.welcome_email(current_user).deliver
		if alarm_msg && alarm_msg.send_alarms_to_all_users
			flash.now[:success] = "Done!!! send to all users"
		else
			flash.now[:danger] = "Some thing is wrong"
		end
		render alarms_new_path
	end

  def show
  end

  def show_all
  	if any_all_alarms_params?
	  	@msg_per_page = show_all_alarms_params[:msg_per_page].empty? ? 10 : show_all_alarms_params[:msg_per_page].to_i
	  	@page_num = show_all_alarms_params[:page_num].empty? ? 1 : show_all_alarms_params[:page_num].to_i
	  end
  end

  private
  def create_alarm_params
	  params.require(:create_alarm).permit(:message)
	end

	def any_all_alarms_params?
		!!params[:all_alarms]
	end

	def show_all_alarms_params
		params.require(:all_alarms).permit(:msg_per_page, :page_num)
	end
end
