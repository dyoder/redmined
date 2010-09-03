class Redmined::Issue

	attr_reader :session, :number
	
	def initialize(session,number)
		@session = session
		@number = number
	end

	def title
		@title ||= css("div.issue > h3").text
	end
	
	def category
		@category ||= css("table.attributes td.category").text
	end
	
	def difficulty 
		@difficulty ||= css("table.attributes tr:last td:last").text.to_i
	end
	
	def priority
		@priority ||= css("table.attributes td.priority").text
	end
	
	def page
		@issue ||= session.get("https://wiki.borderstylo.com/issues/#{number}")
	end
	
	def css(selector)
		page.parser.css(selector)
	end
	
	
end