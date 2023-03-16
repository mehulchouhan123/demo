class Expense < ApplicationRecord
    belongs_to :user
    validates :date, :type_of_expenses, :price , presence: true
    validates :date, comparison: {less_than_or_equal_to: Date.today.strftime("%Y-%m-%d")}
    validates :price, numericality: { only_integer: true }
    # validates_comparison_of :date, less_than_or_equal_to: Date.today
    # validates :name, presence: true
    # validates :name, :login, :email, presence: true
end
