class AddIntendedForToMessages < ActiveRecord::Migration
  def change
    add_reference :messages, :role
  end
end
