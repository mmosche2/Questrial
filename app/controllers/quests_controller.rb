class QuestsController < ApplicationController

  before_filter :authenticate, :except => [:show, :new, :create, :index]

  # GET /quests
  # GET /quests.json
  def index
	@title = "All quests"
	
	@active_quests = Quest.search(params[:search]).where("start <= ? AND enddate >= ?", Date.today, Date.today).order("start ASC").paginate(
											:page => params[:apage], :per_page => 5, :order => 'start')
	@upcoming_quests = Quest.search(params[:search]).where("start > ?", Date.today).order("start ASC").paginate(
											:page => params[:upage], :per_page => 5, :order => 'start')
	@completed_quests = Quest.search(params[:search]).where("enddate < ?", Date.today).order("start ASC").paginate(
											:page => params[:cpage], :per_page => 5, :order => 'start')
	
	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quests }
    end
  end

  # GET /quests/1
  # GET /quests/1.json
  def show
    @quest = Quest.find(params[:id])
	@comments = @quest.comments.paginate(:page => params[:page], :per_page => 5)
	@users = @quest.joiners.paginate(:page => params[:page])
	@status = get_status(@quest)
	@length = (@quest.enddate - @quest.start).to_i + 1
	@launchdays = (Date.today - @quest.start).to_i
	@creator = @quest.user_id ? User.find(@quest.user_id) : User.find(1)
	@category = @quest.category_id ? Category.find(@quest.category_id) : Category.find(1)
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quest }
    end
  end

  # GET /quests/new
  # GET /quests/new.json
  def new
    @quest = Quest.new
	@categories = find_all_categories

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quest }
    end
  end

  # GET /quests/1/edit
  def edit
    @quest = Quest.find(params[:id])
	@categories = find_all_categories
  end

  # POST /quests
  # POST /quests.json
  def create
    @quest = Quest.new(params[:quest])

    respond_to do |format|
      if @quest.save
		current_user.join!(@quest)
        format.html { redirect_to @quest, notice: 'Quest was successfully created.' }
        format.json { render json: @quest, status: :created, location: @quest }
      else
        format.html { render action: "new" }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quests/1
  # PUT /quests/1.json
  def update
    @quest = Quest.find(params[:id])

    respond_to do |format|
      if @quest.update_attributes(params[:quest])
        format.html { redirect_to @quest, notice: 'Quest was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quests/1
  # DELETE /quests/1.json
  def destroy
    @quest = Quest.find(params[:id])
    @quest.destroy

    respond_to do |format|
      format.html { redirect_to quests_url }
      format.json { head :ok }
    end
  end
  
  def joiners
	@title = "Joiners"
	@quest = Quest.find(params[:id])
	@users = @quest.joiners.paginate(:page => params[:id])
	render 'show_joiners'
  end
  
  private
	
	def find_all_categories
		Category.find(:all, :order => "name").map{|c|[c.name,c.id]}
	end
	
  
end
