class AddUserToFunctions < ActiveRecord::Migration[6.0]
  def change
    add_reference :functions, :user, null: false, foreign_key: true
  end
end
