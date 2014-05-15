Sequel.migration do
    up do
        create_table(:peoples) do
        	primary_key :id
            String :id, :null=>false
            String :name, :null=>false
        end
    end

    down do
        drop_table(:peoples)
    end
end