class CreateTechs < ActiveRecord::Migration[6.0]
  def change
    create_table :techs, id: :uuid do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
