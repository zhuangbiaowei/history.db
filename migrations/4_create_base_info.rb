Sequel.migration do
    up do
        create_table(:base_infos) do
            primary_key :id
            String :people_id, :null=>false
            String :info_name, :null=>false
            String :info_value, :null=>false
        end
    end

    down do
        drop_table(:base_infos)
    end
end
