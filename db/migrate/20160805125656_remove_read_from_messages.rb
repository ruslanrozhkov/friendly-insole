class RemoveReadFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :read, :string
  end
end
