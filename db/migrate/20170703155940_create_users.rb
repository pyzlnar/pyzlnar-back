class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.uuid   :uuid,    index: true
      t.string :sub,     index: true
      t.string :username
      t.string :email,   index: true
      t.string :thumbnail
      t.string :role

      t.timestamps
    end
  end
end
