module ApplicationHelper
	def can_display_entry?(entry)
		signed_in? && !current_user.has_blocked?(entry.user) || !signed_in?
	end

	def flash_class(type)
		case type
		when :alert
			"alert-error"
		when :notice
			"alert-success"
		else
			""
		end
	end
end
