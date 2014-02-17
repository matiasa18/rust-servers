class Vote < ActiveRecord::Base
  scope :get_12_hour_votes, -> { where(created_at: 12.hours.ago..Time.zone.now)}

  validate :check_ip

  belongs_to :server



  private
  def check_ip
    errors.add(:base, 'You\'ve already voted today, please wait 12 hours before voting again.') unless Vote.where(ip: ip).get_12_hour_votes.length == 0
  end
end
