class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :code, index: true
      t.string :name
      t.string :status
      t.string :url
      t.date :start_date
      t.date :end_date
      t.string :short
      t.text :description
      t.text :topics, array: true, default: []
      t.timestamps
    end
  end
end
