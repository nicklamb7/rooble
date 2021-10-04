class CreateFunctions < ActiveRecord::Migration[6.0]
  def change
    create_table :functions do |t|
      t.string :name
      t.text :description
      t.text :example
      t.references :type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
