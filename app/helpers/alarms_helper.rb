module AlarmsHelper

	def get_total_msg_num
		return @msg_count ||= Alarm.count
	end

	def show_alarms(user)
		return Alarm.all.select do |alarm|
			user.id.to_s == alarm.user_id
		end
	end

	def get_total_pages(per_page)
		per_page = 1 if per_page < 1
		return (get_total_msg_num - 1)/per_page + 1
	end

	def show_all_alarms(per_page, page_index)
		per_page = 1 if per_page < 1
		page_index = 0 if page_index < 0
		alarms = []
		total_pages = get_total_pages(per_page)
		page_index = total_pages - 1 if page_index >= total_pages
		Alarm.find_each(batch_size: per_page, start: page_index*per_page + 1, finish: (page_index + 1)*per_page) do |alarm|
			alarms << alarm
		end if page_index < total_pages
		return alarms
	end
end
