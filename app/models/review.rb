class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue
  attr_accessible :review, :is_verified, :verified_by, :rating_venue, :rating_food, :rating_services, :rating_facilities, :rating_total, :rating_count

#  validate :any_one_value
#  
#  def any_one_value
#    if (rating_venue.nil? && rating_food.nil? && rating_services.nil? && rating_facilities.nil? && review.blank?)
#      errors[:base] << ("Please enter at least one value")
#    end
#  end
end
