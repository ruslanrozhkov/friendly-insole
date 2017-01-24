class CreateOrderForms < ActiveRecord::Migration
  def change
    create_table :order_forms do |t|
      t.string :patient_id
      t.integer :age
      t.string :weight
      t.string :shoe_size
      t.string :gender
      t.string :diabetic
      t.text :notes
      t.belongs_to :line_item

      t.timestamps null: false
    end
  end
end
