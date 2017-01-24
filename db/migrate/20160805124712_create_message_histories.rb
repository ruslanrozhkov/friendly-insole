class CreateMessageHistories < ActiveRecord::Migration
  def change
    create_table :message_histories do |t|
      t.belongs_to :message
      t.belongs_to :user
      t.boolean :read

      t.timestamps null: false
    end
  end
end
