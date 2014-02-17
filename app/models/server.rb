class Server < ActiveRecord::Base
  # relationships
  belongs_to :user
  has_many :votes
  has_many :uptime_checks

  # scopes
  scope :recent, -> { order('created_at DESC') }
  scope :for_user, lambda { |user_id| where(user_id: user_id) }

  # validations
  validates :ip, presence: true, format: { with: /[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\:[0-9]{1,5}/ }
  validates :name, presence: true, length: { maximum: 40, minimum: 5 }
  validates :description, presence: true, length: { maximum: 500 }

end
