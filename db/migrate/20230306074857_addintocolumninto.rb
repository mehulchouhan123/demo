class Addintocolumninto < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.integer :price
      t.string :type
      t.string :date
      t.belongs_to :user,index: true, foreign_key: true
      t.timestamps
    end
  end
end
