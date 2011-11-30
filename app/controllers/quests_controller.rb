class QuestsController < ApplicationController

  before_filter :authenticate, :except => [:show, :new, :create, :index]

  # GET /quests
  # GET /quests.json
  def index
	@title = "All quests"
	@categories = find_all_categories

	@active_quests = Quest.where("start <= ? AND enddate >= ?", Date.today, Date.today)
	@upcoming_quests = Quest.where("start > ?", Date.today)
	@completed_quests = Quest.where("enddate < ?", Date.today)	
	

	
	sort_upcoming = "start ASC, Joiners_count DESC"
	sort_active = "start DESC, Joiners_count DESC"
	sort_completed = "start DESC, Joiners_count DESC"
	
	if (!params[:quest].blank?)
		if (!params[:quest][:sort].blank?)
			@selected_sort = params[:quest][:sort]
			
			if (@selected_sort == "2")
				sort_upcoming = "Joiners_count DESC, start ASC"
				sort_active = "Joiners_count DESC, start DESC"
				sort_completed = "Joiners_count DESC, start DESC"
			end
		end
			
	end

	
	@active_quests = @active_quests.order(sort_active)
	@upcoming_quests = @upcoming_quests.order(sort_upcoming)
	@completed_quests = @completed_quests.order(sort_completed)	
	
	
	if (!params[:search].blank?)
		@active_quests = @active_quests.search(params[:search])
		@upcoming_quests = @upcoming_quests.search(params[:search])
		@completed_quests = @completed_quests.search(params[:search])
	end
	
	if (!params[:quest].blank?)
		if (!params[:quest][:category].blank?)
			@selected_category = params[:quest][:category]
			@active_quests = @active_quests.search_by_category(@selected_category)
			@upcoming_quests = @upcoming_quests.search_by_category(@selected_category)
			@completed_quests = @completed_quests.search_by_category(@selected_category)
		end
		
	end
	
	@active_quests_size = @active_quests.size
	@upcoming_quests_size = @upcoming_quests.size
	@completed_quests_size = @completed_quests.size
	
	@active_quests = @active_quests.paginate(:page => params[:apage], :per_page => 5)
	@upcoming_quests = @upcoming_quests.paginate(:page => params[:upage], :per_page => 5)
	@completed_quests = @completed_quests.paginate(:page => params[:cpage], :per_page => 5)
	
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
	@categories = find_all_categories

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
