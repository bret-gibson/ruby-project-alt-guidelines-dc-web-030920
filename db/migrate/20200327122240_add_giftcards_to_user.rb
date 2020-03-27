class AddGiftcardsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gift_cards, :integer
  end
end
