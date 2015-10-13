module WktimePlugin
	class Hooks < Redmine::Hook::ViewListener

		render_on :view_my_account_preferences,
				  :partial => 'hooks/wktime/view_my_account_preferences'
		render_on :view_users_form_preferences,
				  :partial => 'hooks/wktime/view_users_form_preferences'
	end
end