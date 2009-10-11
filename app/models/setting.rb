class Setting < ActiveRecord::Base
  acts_as_authorizable

  private
  def validate
    errors.add_on_empty %w( key value )
  end
end
