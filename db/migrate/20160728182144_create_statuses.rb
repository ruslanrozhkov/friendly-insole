class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.belongs_to :order
      t.string :current, :default => 'pending approval'
      t.string :previous
      t.string :next, :default => 'approved'

      t.timestamps null: false
    end
  end
end
