require "kramdown"
require File.dirname(__FILE__)+"/model.rb"

def parse_file(f,type)
	id=f.gsub(File.dirname(f)+"/","").split(".")[0]
	text=IO.read(f)
	doc=Kramdown::Document.new(text)
	if(type=='people')
		return parse_people(id,doc)
	end
end

def parse_people(id,doc)
	doc.root.children.each do |child|
		if child.type==:header
			if child.options[:level]==1
				puts child.options[:raw_text]
			end
		end
	end
end