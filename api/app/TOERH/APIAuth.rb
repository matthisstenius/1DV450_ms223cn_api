class TOERH::APIAuth
	def api_access(token)
		unless ApiKey.exists?(api_key: token)
			raise Exception, "Access to API denied"
		end
	end
end