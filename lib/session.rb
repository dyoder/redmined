require 'mechanize'
class Redmined::Session

	attr_reader :url
	
	def initialize(url,login=nil,password=nil)
		@url = url
		@agent = Mechanize.new
		@agent.basic_auth(login,password) if login
	end
	
	def get(url)
		@agent.get(url)
	end
	
	def issues(project)
		@issues ||= Redmined::Issues.new(self,project)
	end
	
	def wiki(project)
		@wiki ||= Redmined::Wiki.new(self,project)
	end
	
end