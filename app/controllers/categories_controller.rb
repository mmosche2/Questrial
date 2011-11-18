class CategoriesController < ApplicationController

  before_filter :authenticate 
  before_filter :admin_user,	:only => [:destroy, :new, :create, :edit, :update]

  # GET /categories
  # GET /categories.json
  def index
	@categories = Category.all
  
	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category }
    end
  end

  # GET /category/1
  # GET /category/1.json
  def show
    @category = Category.find(params[:id])

	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /category/new
  # GET /category/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /category/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /category
  # POST /category.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /category/1
  # PUT /category/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category/1
  # DELETE /category/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_path }
      format.json { head :ok }
    end
  end

	

end
