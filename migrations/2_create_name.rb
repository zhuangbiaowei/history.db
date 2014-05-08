Sequel.migration do
    up do
        create_table(:names) do
            primary_key :id
            String :people_id, :null=>false
            String :name_name, :null=>false
            String :name_value, :null=>false
        end
    end

    down do
        drop_table(:names)
    end
end
