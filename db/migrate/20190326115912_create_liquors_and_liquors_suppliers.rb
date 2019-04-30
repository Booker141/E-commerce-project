class CreateLiquorsAndLiquorsSuppliers < ActiveRecord::Migration[5.1]
   def up
    create_table :liquors do |t|
      t.string :name, :limit => 255, :null => false
      t.integer :producer_id, :limit => 8, :null => false
      t.datetime :produced_at
      t.text :blurb
      t.integer :graduation 
      t.float :price
      t.timestamps
    end

    create_table :liquors_suppliers do |t|
      t.integer :liquor_id, :limit => 8, :null => false
      t.integer :supplier_id, :limit => 8, :null => false
      t.timestamps
    end

    say_with_time 'Adding foreing keys' do
      # Add foreign key reference to liquors_suppliers table
      execute 'ALTER TABLE liquors_suppliers ADD CONSTRAINT fk_liquors_suppliers_liquors
              FOREIGN KEY (liquor_id) REFERENCES liquors(id) ON DELETE CASCADE'      
      execute 'ALTER TABLE liquors_suppliers ADD CONSTRAINT fk_liquors_suppliers_suppliers
              FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE'
      # Add foreign key reference to liquors table
      execute 'ALTER TABLE liquors ADD CONSTRAINT fk_liquors_producers
              FOREIGN KEY (producer_id) REFERENCES producers(id) ON DELETE CASCADE'
    end
  end

  def self.down
    drop_table :liquors
    drop_table :liquors_suppliers
  end
end
