class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def email_required?
  	false
  end
  def email_changed?
  	false
  end
  def will_save_change_to_email?
  	false
	end

	validates :name, uniqueness: true
	has_many :messages
	has_many :rooms
end
