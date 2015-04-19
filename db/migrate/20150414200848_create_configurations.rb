class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.string :name
      t.string :value
      t.string :value_type

      t.timestamps null: false
    end
  end
end