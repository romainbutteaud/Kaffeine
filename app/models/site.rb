class Site < ActiveRecord::Base
  def defaults
    self.nap ||= false
    self.bedtime||= "00:00"
  end
end
