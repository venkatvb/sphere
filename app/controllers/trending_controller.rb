class TrendingController < ApplicationController
	def get
		require 'open-uri'
		problem = {}
		handle = {}
		time = {}
		mem = {}
		lang = {}
		ac = {}
		wa = {}
		re = {}
		tle = {}
		ce = {}
		count = {}
		(1..5).each do |i|
			a = JSON.load(open(status_url(:id => i)))
			if a["status"] == true
				a["result"].each do |p|
					id = p["problem_url"]
					problem[id] ||= p["problem"]
					handle[id] ||= []
					handle[id] << p["user_url"]
					time[id] ||= []
					mem[id] ||= []
					lang[id] ||= []
					ac[id] ||= 0
					ce[id] ||= 0
					tle[id] ||= 0
					wa[id] ||= 0
					re[id] ||= 0
					count[id] ||= 0
					count[id] += 1
					if p["result"].downcase.include? "accepted"
						ac[id] += 1
						time[id] << p["time"]
						mem[id] << p["mem"]	
						lang[id] << p["lang"]
					end
					if p["result"].downcase.include? "compil"
						ce[id] += 1
					end
					if p["result"].downcase.include? "time"
						tle[id] += 1
					end
					if p["result"].downcase.include? "wrong"
						wa[id] += 1
					end
					if p["result"].downcase.include? "runtime"
						re[id] += 1
					end
				end	
			end	
		end
		response = {}
		response[:status] = true
		res = []
		problem.each do |url, problem|
			t = {}
			t[:url] = url
			t[:problem] = problem
			t[:ac] = ac[url]
			t[:tle] = tle[url]
			t[:wa] = wa[url]
			t[:re] = re[url]
			t[:ce] = ce[url]
			t[:handle] = handle[url]
			t[:time] = time[url]
			t[:mem] = mem[url]
			t[:lang] = lang[url]
			t[:count] = count[url]
			res << t
		end		
		response[:result] = res
		render json: response
	end
end
