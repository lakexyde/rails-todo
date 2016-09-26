class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create]
  def create
	@todo_item = @todo_list.todo_items.create(todo_items_params)
	if @todo_item.save
      redirect_to @todo_list
     end
  end

  def destroy
  	if @todo_item.destroy
  		flash[:success] = "Todo list item has been successfully deleted"
  	else
  		flash[:error] = "Tod List item could not be deleted"
  	end
  	redirect_to @todo_list
  end

  def complete
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Todo item completed"

  end
  private

  def set_todo_item
  	@todo_item = @todo_list.todo_items.find(params[:id])

  end

  def set_todo_list
  	@todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_items_params
  	params.require(:todo_item).permit(:content)
  end

end
