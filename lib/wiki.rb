class Redmined::Wiki
	attr_reader :session, :project
		
	def initialize(session,project)
		@session = session
		@project = project
	end
	
	def page(name)
		Redmined::Page.new(session,self,name)
	end
	
	def url
		"#{session.url}#{path}"
	end
	
	def path
		"/projects/#{project}/wiki"
	end
	
end