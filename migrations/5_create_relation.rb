Sequel.migration do
    up do
        create_table(:relations) do
            primary_key :id
            String :people_id, :null=>false
            String :relation_name, :null=>false
            String :relation_people_name, :null=>false
            String :relation_people_id
        end
    end

    down do
        drop_table(:relations)
    end
end
