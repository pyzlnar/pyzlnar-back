class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :code, index: true
      t.string :name
      t.string :status
      t.string :url
      t.text :description
      t.text :topics, array: true, default: []
      t.timestamps
    end
  end
end
