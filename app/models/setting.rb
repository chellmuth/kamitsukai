class Setting < ActiveRecord::Base
  acts_as_authorizable

  validates_uniqueness_of :key

  def validate
    errors.add_on_empty %w( key value )
  end
end
