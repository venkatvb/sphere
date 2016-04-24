class StatusController < ApplicationController
	include ScraperConcern
	def get
		id = Integer(params[:id]) rescue nil
		if (id == nil) or (id <= 0) or (id > 5)
			response = {}
			response[:status] = false
			response[:message] = "Error in status page identifier " + id.to_s + ". Status Page Identifier must be an interger from 1 to 5 inclusive."
			render json: response
		else
			url = "http://www.spoj.com/status/start=" + ((id - 1) * 20 ).to_s
			doc = getNokogiriDoc(url)
			response = {}
			response[:status] = true
			res = []
			doc.css("td").each_slice(8) do |id, date, user, problem, result, time, mem, lang, blank|
				t = {}
				t[:id] = id.text.strip rescue nil
				t[:date] = date.text.strip rescue nil
				t[:problem] = problem.text.strip rescue nil
				t[:result] = result.text.strip rescue nil
				t[:time] = time.text.strip rescue nil
				t[:mem] = mem.text.strip rescue nil
				t[:lang] = lang.text.strip rescue nil
				res << t
			end
			response[:result] = res
			render json: response
		end
	end
end
