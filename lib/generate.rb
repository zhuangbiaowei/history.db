current_path=File.dirname(__FILE__)
require current_path+"/parse_data.rb"

path = current_path+"/../incoming/"

Dir.new(path).each do |f|
	if(f!="." && f!="..")
		parse_file(path+f)
	end
end