current_path=File.dirname(__FILE__)
require current_path+"/parse_data.rb"

path = current_path+"/../incoming/"

Dir.new(path).each do |f|
	if(f!="." && f!="..")
		unless File.directory?(path+f)
			parsed_data=parse_file(path+f,nil)
		else
			Dir.new(path+f).each do |sub_f|
				if(sub_f!="." && sub_f!="..")
					parsed_data=parse_file(path+f+"/"+sub_f,f)
				end
			end
		end
	end
end