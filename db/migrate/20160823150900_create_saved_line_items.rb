class CreateSavedLineItems < ActiveRecord::Migration
  def change
    create_table :saved_line_items do |t|
      t.belongs_to :user
      t.belongs_to :variant
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
