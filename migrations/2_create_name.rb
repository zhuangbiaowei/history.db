Sequel.migration do
    up do
        create_table(:name) do
            primary_key :id
            Integer :people_id, :null=>false
            String :name_name, :null=>false
            String :name_value, :null=>false
        end
    end

    down do
        drop_table(:name)
    end
end
