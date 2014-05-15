require "pp"
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
	people=People.where(:id=>id).first
	unless people
		people = People.new
		people.id=id
	end
	wait_type=nil
	doc.root.children.each do |child|
		if child.type==:header
			if child.options[:level]==1
				people.name=child.options[:raw_text]
			elsif child.options[:level]==2
				if child.options[:raw_text]=="姓名"
					wait_type=:name
				elsif child.options[:raw_text]=="基本信息"
					wait_type=:base_info
				elsif child.options[:raw_text]=="人际关系"
					wait_type=:relation
				end
			end
		end
		if child.type==:ul
			if wait_type==:name
				parse_people_name(people,child)
			elsif wait_type==:base_info
				parse_people_base_info(people,child)
			elsif wait_type==:relation
				parse_people_relation(people,child)
			end
			wait_type=nil
		end
	end
	people.save
end

def parse_people_name(people,element)
	element.children.each do |child|
		name_value=child.children[0].children[0].value.split(": ")
		name = Name.where(:people_id=>people.id).where(:name_name=>name_value[0]).first
		name=Name.new unless name
		name.people_id=people.id
		name.name_name=name_value[0]
		name.name_value=name_value[1]
		name.save
		people.names<<name
	end
end

def parse_people_base_info(people,element)
	element.children.each do |child|
		pp child.children[0]
		pp child.children[0].children[0].value.split(": ")
		info_value=child.children[0].children[0].value.split(": ")
		base_info = BaseInfo.where(:people_id=>people.id).where(:info_name=>info_value[0]).first
		base_info=BaseInfo.new unless base_info
		base_info.people_id=people.id
		base_info.info_name=info_value[0]
		base_info.info_value=info_value[1]
		#base_info.save
		people.base_infos<<base_info
	end
end

def parse_people_relation(people,element)
end