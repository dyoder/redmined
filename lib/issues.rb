class Redmined::Issues
	attr_reader :session, :project
	
	include Enumerable
	
	def initialize(session,project)
		@session = session
		@project = project
	end
	
	def get
		@issues ||= begin
			page = session.get(url)
			load = lambda do
				page.parser.css("table.issues.list tbody tr.issue td.id a").map { |dom| Redmined::Issue.new(session,dom.text) }
			end
			get_next = lambda do
				page.links.find { |link| link.text =~ /Next/ }
			end
			issues = [] ; loop do
				issues += load.call
				next_page = get_next.call
				break unless next_page
				page = next_page.click
			end
			issues
		end
	end
	
	def each
		get.each { |issue| yield(issue) if block_given? }
	end
	
	def url
		"#{session.url}/projects/#{project}/issues"
	end
	
end