class Addcolintoexpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :type_of_expenses, :string
    remove_column :expenses, :type, :string
  end
end
