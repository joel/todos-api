class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'

    create_table :todos, id: :uuid do |t|
      t.string :title
      t.string :created_by

      t.timestamps
    end
  end
end
