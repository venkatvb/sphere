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
				t[:id] = id.text rescue nil
				t[:date] = date.text rescue nil
				t[:user] = user.text rescue nil
				t[:user_url] = user.css("a").first.attr("href") rescue nil
				t[:problem] = problem.text rescue nil
				t[:problem_url] = problem.css("a").first.attr("href") rescue nil
				t[:result] = result.text rescue nil
				t[:time] = time.text rescue nil
				t[:mem] = mem.text rescue nil
				t[:lang] = lang.text rescue nil
				res << t
			end
			response[:result] = res
			render json: response
		end
	end
end
