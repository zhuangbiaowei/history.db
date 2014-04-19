Sequel.migration do
    up do
        create_table(:meta) do
            primary_key :id
            String :type, :null=>false
            String :table, :null=>false
            String :values, :null=>false
        end
    end

    down do
        drop_table(:meta)
    end
end
