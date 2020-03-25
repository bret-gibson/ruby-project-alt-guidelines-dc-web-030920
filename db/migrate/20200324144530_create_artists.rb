class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
    t.string :name
    t.integer :deezer_id
    t.timestamps
    end
  end
end
