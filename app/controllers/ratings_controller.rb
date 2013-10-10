class RatingsController < ApplicationController
  before_filter :get_venue

  def get_venue
    @venue = Venue.find(params[:venue_id])
  end

  def rate
      @rating = Rating.new
      @rating.rating = params[:rating].to_i
      @rating.venue_id = @venue.id
      if current_user.nil?
        @rating.client_ip = request.remote_ip
      else
        @rating.user_id = current_user.id
      end
      
      @rating_count = (@venue.rating_count == nil ? 0 : @venue.rating_count) + 1
      @rating_total = (@venue.rating_total == nil ? 0 : @venue.rating_total) + @rating.rating

      respond_to do |format|
        if @rating.save
#          @rating_count = Rating.getCount(@venue.id)
#          @rating_average = Rating.getAverage(@venue.id, @rating_count)
          
          @venue.update_attributes(:rating =>  (@rating_total.to_f / @rating_count.to_f), :rating_count =>  @rating_count, :rating_total => @rating_total)
          format.js
        end
     end
   end
end