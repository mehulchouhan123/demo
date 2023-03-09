class Expense < ApplicationRecord
    belongs_to :user
    validates :date, :type_of_expenses, :price , presence: true
    # validates :name, presence: true
    # validates :name, :login, :email, presence: true
end
