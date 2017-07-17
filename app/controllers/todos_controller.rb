class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    json_response(relation: Todo.all, is_collection: true)
  end

  # POST /todos
  def create
    todo = Todo.create!(todo_params)
    json_response(relation: todo, status: :created)
  end

  # GET /todos/:id
  def show
    json_response(relation: @todo)
  end

  # PUT /todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    # whitelist params
    params.permit(:title, :created_by)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
