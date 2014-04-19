Sequel.migration do
    up do
        create_table(:people) do
            primary_key :id
            String :name, :null=>false
        end
    end

    down do
        drop_table(:people)
    end
end
