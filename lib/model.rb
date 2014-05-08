require 'sequel'

current_path=File.dirname(__FILE__)

DB=Sequel.sqlite(current_path+"/../db/history.db")

class People < Sequel::Model
end