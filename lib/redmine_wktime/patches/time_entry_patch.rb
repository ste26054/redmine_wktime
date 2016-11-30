module RedmineWktime
	module Patches
		module TimeEntryPatch
			def self.included(base)
				base.send(:include)
			
				base.class_eval do
					unloadable

					before_destroy :check_if_time_entry_is_wklocked
					before_save :check_if_time_entry_is_wklocked

					def check_if_time_entry_is_wklocked
					
						wktime_helper = Object.new.extend(WktimeHelper)
						status = wktime_helper.getTimeEntryStatus(self.spent_on, self.user_id)
						if !status.blank? && ('a' == status || 's' == status || 'l' == status)
							errors.add(:base, l(:label_warning_wktime_time_entry))
								return false
							
							# errors.add(:base, "Can not delete because it is attached to a submitted invoice")
        					
						end
						
						

					
					end
				end
			end
		end
	end
end

unless TimeEntry.included_modules.include?(RedmineWktime::Patches::TimeEntryPatch)
  TimeEntry.send(:include, RedmineWktime::Patches::TimeEntryPatch)
end