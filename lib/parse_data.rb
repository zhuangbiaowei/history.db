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
				case child.options[:raw_text]
				when "姓名","Name" then
					wait_type=:name
				when "基本信息","Info" then
					wait_type=:base_info
				when "人际关系","Relation" then
					wait_type=:relation
				else
					wait_type=nil
				end
			end
		end
		if child.type==:ul
			case wait_type
			when :name then
				parse_people_name(people,child)
			when :base_info then
				parse_people_base_info(people,child)
			when :relation then
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
		info_value=child.children[0].children[0].value.split(": ")
		if info_value.length>0
			base_info = BaseInfo.where(:people_id=>people.id).where(:info_name=>info_value[0]).first
			base_info=BaseInfo.new unless base_info
			base_info.people_id=people.id
			base_info.info_name=info_value[0]

			locate=0
			value=""		
			child.children[0].children.each do |sub|
				if locate>0
					if sub.type==:a
						value=value+"[#{sub.children[0].value}](#{sub.attr["href"]})"
					end
					if sub.type==:text
						value=value+sub.value
					end
				end
				locate=locate+1
			end
			base_info.info_value=value
			base_info.save
			people.base_infos<<base_info
		end
	end
end

def parse_people_relation(people,element)
	element.children.each do |child|
		locate=0
		relation=""
		child.children[0].children.each do |sub|
			if locate==0
				relation=sub.value.split(":")[0]
			else
				if sub.type==:a
					puts people.id
					puts people.name
					puts relation
					puts sub.children[0].value
				end
			end
			locate=locate+1
		end
	end
end
