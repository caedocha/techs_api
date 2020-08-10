class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links, id: :uuid do |t|
      t.references :category, index: true, type: :uuid, unique: true
      t.references :tech, index: true, type: :uuid, unique: true
    end

    add_index :links, [:category_id, :tech_id], unique: true
  end
end
