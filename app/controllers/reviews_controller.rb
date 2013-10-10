class ReviewsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  

  before_filter :get_venue

  def get_venue
    @venue = Venue.find(params[:venue_id])
  end


  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = @venue.reviews.all
    @review = Review.new

    respond_to do |format|
      format.js # index.js.erb
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.js # show.js.erb
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new

    respond_to do |format|
      format.js # new.js.erb
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])

    respond_to do |format|
      format.js # new.js.erb
    end
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(params[:review])
    @review.venue_id = @venue.id
    @review.user_id = current_user.id
    
    rating = getRatingArray(@review)
    @review.rating_count = rating.length
    @review.rating_total = rating.sum

    respond_to do |format|
      if @review.save
        @rating_count = (@venue.rating_count == nil ? 0 : @venue.rating_count) + rating.length
        @rating_total = (@venue.rating_total == nil ? 0 : @venue.rating_total) + rating.sum
        @venue.update_attributes(:rating =>  (@rating_total.to_f / @rating_count.to_f), :rating_count =>  @rating_count, :rating_total => @rating_total)
        
        @review = Review.new
        format.js 
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])
    
    rating = getRatingArray(Review.new(params[:review]))
    @rating_count = (@venue.rating_count == nil ? 0 : @venue.rating_count) - (@review.rating_count == nil ? 0 : @review.rating_count) + rating.length
    @rating_total = (@venue.rating_total == nil ? 0 : @venue.rating_total) - (@review.rating_total == nil ? 0 : @review.rating_total) + rating.sum

    respond_to do |format|
      if @review.update_attributes(params[:review].merge(:rating_count =>  rating.length, :rating_total => rating.sum))
        @venue.update_attributes(:rating =>  (@rating_total.to_f / @rating_count.to_f), :rating_count =>  @rating_count, :rating_total => @rating_total)
        
        @review = Review.new
        format.js 
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    
    @rating_count = (@venue.rating_count == nil ? 0 : @venue.rating_count) - (@review.rating_count == nil ? 0 : @review.rating_count)
    @rating_total = (@venue.rating_total == nil ? 0 : @venue.rating_total) - (@review.rating_total == nil ? 0 : @review.rating_total)
    
    if @review.destroy
      @venue.update_attributes(:rating =>  (@rating_total.to_f / @rating_count.to_f), :rating_count =>  @rating_count, :rating_total => @rating_total)
    end
    
    respond_to do |format|
      @review = Review.new
      format.js
    end
  end
  
  def getRatingArray(review)
    rating = Array.new
    
    rating << review.rating_venue unless review.rating_venue.nil?
    rating << review.rating_food unless review.rating_food.nil?
    rating << review.rating_services unless review.rating_services.nil?
    rating << review.rating_facilities unless review.rating_facilities.nil?
        
    return rating
  end
end
