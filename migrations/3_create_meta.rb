Sequel.migration do
    up do
        create_table(:metas) do
            primary_key :id
            String :id, :null=>false
            String :type, :null=>false
            String :table, :null=>false
            String :values, :null=>false
        end
    end

    down do
        drop_table(:metas)
    end
end
