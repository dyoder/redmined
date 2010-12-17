class Redmined::Issue

	attr_reader :session, :number
	
	def to_hash
		rval = {}
		%w( number title category products_status status difficulty dependency priority ).each do |method|
			rval[method.to_sym] = send(method)
		end
		rval
	end
	
	def self.from_hash(session,hash)
		rval = self.new(session,hash[:number])
		hash.each do |key,value|
			rval.instance_eval do 
				instance_variable_set("@#{key}",value)
			end
		end
		rval
	end
	
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
	
	def products_status 
		@products_status ||= css("table.attributes th:contains('Products Status') + td").text
	end
	
	def status 
		@status ||= css("table.attributes th:contains('Status') + td").text
	end
	
	def closed?
		status == "Closed"
	end

	def difficulty 
		@difficulty ||= css("table.attributes th:contains('Dificulty') + td").text.to_i
	end
	
	def dependencies
		@dependencies ||= begin
			dx = css("#relations td:contains('follows') a").map do |d| 
				d = d.text.match(/\d+/)
				d.to_s if d
			end
		end
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