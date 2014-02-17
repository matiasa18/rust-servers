class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :servers, dependent: :destroy

  validate :username, presence: true, uniqueness: true, format: { with: /[a-zA-Z0-9]{4,20}/ }
end
