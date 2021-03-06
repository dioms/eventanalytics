class User < ActiveRecord::Base
  after_create :create_api_key
  has_many :events
  has_many :customers
  has_many :customer_sets
  has_one :api_key
  belongs_to :plan

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

  def create_api_key
    ApiKey.create(user_id: self.id).save
  end
end
