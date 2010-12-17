class Redmined::Page

	attr_reader :session, :wiki, :name
	attr_writer :content
	
	def initialize(session,wiki,name)
		@session = session
		@wiki = wiki
		@name = name
	end

	def title
		@title ||= css("div.wiki h1").to_a.first.text
	end
	
	def html
		@html ||= session.get("#{wiki.url}/#{name}")
	end
	
	def content
		@content ||= css("div.wiki")
	end
	
	def save
		editor_url = 
		editor = session.get("#{wiki.url}/#{name}/edit")
		form = editor.form_with(:action => "#{wiki.path}/#{name}/edit")
		form["content[text]"] = @content
		form.submit
	end
	
	def css(selector)
		html.parser.css(selector)
	end
	
end