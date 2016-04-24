module ScraperConcern
	extend ActiveSupport::Concern

	included do
		helper_method :mymethod
		helper_method :getNokogiriDoc
	end

	def mymethod
		return 5
	end

	def getNokogiriDoc (url)
		begin
			require 'rubygems'
			require 'nokogiri'
			require 'open-uri'
			require 'uri'
			url = URI.encode(url)
			doc = Nokogiri::HTML(open(url))
			return doc
		rescue Exception => e
			return false
		end
	end

end