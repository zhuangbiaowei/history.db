require 'pp'
require 'sequel'

current_path=File.dirname(__FILE__)

DB=Sequel.sqlite(current_path+"/../db/history.db")

class Name < Sequel::Model
	many_to_one :people
end

class BaseInfo < Sequel::Model
	many_to_one :people
end

class Relation < Sequel::Model
end

class Meta < Sequel::Model
end

class People < Sequel::Model
	set_primary_key :id
	one_to_many :names
	one_to_many :base_infos
end

class Relations < Sequel::Model
end

