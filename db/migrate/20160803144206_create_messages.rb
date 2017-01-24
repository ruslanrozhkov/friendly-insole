class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :order
      t.belongs_to :user
      t.text :body
      t.boolean :read

      t.timestamps null: false
    end
  end
end
