require "kramdown"

def parse_file(f)
	text=IO.read(f)
	doc=Kramdown::Document.new(text)
	puts doc.to_html
end