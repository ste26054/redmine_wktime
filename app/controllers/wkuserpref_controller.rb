class WkuserprefController < WktimeController	
unloadable



	def log_in_days
			#----- add a preference for 'logTimeInDays' -----#

		@user = User.find(params[:user_id])
		if @user.pref[:logTimeInDays] == "1"
			@user.pref[:logTimeInDays] = "0"
			@user.pref[:exceedLogTimeLimit] = "0"
		else
			@user.pref[:logTimeInDays] = "1"
			
		end
		@user.preference.save
		@logTimeInDays = @user.pref[:logTimeInDays] if @user.pref[:logTimeInDays].present?
	 
	 	redirect_to wkuserpref_index_path(:tab => "wkuserpref")
		

	end

	def limit_log_time_entry
		@user = User.find(params[:user_id])
		if @user.pref[:exceedLogTimeLimit] == "1"
			@user.pref[:exceedLogTimeLimit] = "0"
		else
			@user.pref[:exceedLogTimeLimit] = "1"
		end
		@user.preference.save
		@exceedLogTimeLimit = @user.pref[:exceedLogTimeLimit] if @user.pref[:exceedLogTimeLimit].present?
	 
		redirect_to wkuserpref_index_path(:tab => "wkuserpref")
		
	end
end