class ExpensesController < ApplicationController
  def index
    # byebug
   
    @expense=Expense.new
    if !user_signed_in?
      redirect_to new_user_session_path
    end
    # byebug
    if @current_user!=nil

      @expenses=User.find(current_user.id).expenses
    end
  end
  def search
    byebug
    debugger
  end
  def create
    
    if params[:commit]=="Save"
    
      cid=current_user.id
      expense=Expense.new(param_expense)
      expense.user_id=cid
      expense.save!
      redirect_to root_path
    else
      # debugger
      @date=nil
      if params[:date]="Last year"
        @date=Expense.where('date >=?',Date.today.last_year)
        @date=Date.today.last_year
      elsif params[:date]="Last week"
        @date=Expense.where('date >=?',Date.today.last-week)
        @date=Date.today.last_week
        
      elsif params[:date]="Last month"
        @date=Expense.where('date >=?',Date.today.last_month)
        @date=Date.today.last_month
        
      else
        @date=Expense.where('date =?',Date.today)
        @date=Date.today
      end
      debugger




      #   today=  Expense.where('date =?',Date.today)
      # end

      # require 'date'
      # for 
      # for lastweek=  Expense.where('date =?',Date.today.last-week)
      # for lastweek=  Expense.where('date =?',Date.today.last_month)
      # for lastweek=  Expense.where('date =?',Date.today.last_year)

     
      if params[:date]=today
        @expenses=Expense.where("type_of_expenses=? AND date=? AND user_id=?" ,"Education",today,current_user.id)
        debugger
      

      end
    end


  end
  def edit
    @expense=Expense.find(params[:id])

  end
  def destroy
    @expense=Expense.find(params[:id])
    @expense.destroy
  end
  private
  def param_expense
    params.require(:expense).permit(:title,:price,:type_of_expenses,:date)
  end
end
