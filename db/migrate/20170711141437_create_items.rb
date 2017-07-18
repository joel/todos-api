class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items, id: :uuid do |t|
      t.string :name
      t.boolean :done
      t.references :todo, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
