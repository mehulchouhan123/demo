class ExpensesController < ApplicationController
  def index
    # debugger
   
    @expense=Expense.new
    if !user_signed_in?
      redirect_to new_user_session_path
    end

    if @current_user!=nil
      # @count
      c_id=current_user.id

      @expenses=Expense.where("date>=? AND user_id=?",Date.today,c_id)
      if params[:date]!=nil

      @expenses=Expense.where("date>=? AND user_id=?",params[:date],c_id)
      end
      # debugger
      if params[:array]!=nil
        if params[:array].size==1
          @expenses=Expense.where("type_of_expenses=? AND date>=? AND user_id=?",params[:array][0],params[:date],c_id)
        elsif  params[:array].size==2
          # debugger
          @expenses=Expense.where("type_of_expenses=? OR type_of_expenses=?AND date>=?AND user_id=?",params[:array][0], params[:array][1],params[:date],c_id)
        elsif params[:array].size==3
          # debugger
          @expenses=Expense.where("type_of_expenses=? OR type_of_expenses=? OR  type_of_expenses=? AND date>=? AND user_id=?",params[:array][0],params[:array][1],params[:array][2],params[:date],c_id)
        end
      end
    end
    
    # debugger
  end
  
  def create
    # debugger
    
    if params[:commit]=='Save'
      cid=current_user.id
      expense=Expense.new(param_expense)
      expense.user_id=cid
      expense.save!
      redirect_to root_path
    else
      @date=Date.today
      if params[:date]=="Last week"
        @date=Date.today.last_week
      elsif params[:date]=="Last month"
        @date=Date.today.ago(1.month).beginning_of_month
      elsif params[:date]=="Last year"
        @date=Date.today.ago(1.year).beginning_of_year
      end

      @hash={"Education"=>0,"Clothes"=>"0","Food"=>"0"}
      a=Array.new
      @hash.each do |k,v|
        v=params[k]
        if v=="1"
          a.push(k)
        end
      end
      redirect_to root_path(array: a,date: @date)
 
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
