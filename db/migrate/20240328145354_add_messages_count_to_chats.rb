class AddMessagesCountToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :messages_count, :integer, default: 0
    add_index :chats, [:number, :application_id]
  end
end
