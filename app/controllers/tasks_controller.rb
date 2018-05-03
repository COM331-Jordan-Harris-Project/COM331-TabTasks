class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # IS THIS CORRECT BELOW? This change was manually edited from
  # https://github.com/jmynes/COM331-Userblog/commit/0d5c9aba4c9e476fdcc6e3690efd205f233b82a2

  # Authenticate users on following pages (except...)
  before_action :authenticate_user, except: [:index, :show]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    if @tasks.present?
      @reminder = @tasks.sample.verb
    end

    # @due = @tasks.sample.deadline.timeframe
    # Compare to timestamp of task creation, do some math
      #
  end

  # GET /tasks/list
  def cpanel
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        puts @task.errors.full_messages
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:verb, deadline_attributes: [:timeframe, :urgency])
    end
end
