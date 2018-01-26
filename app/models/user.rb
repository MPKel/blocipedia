class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis

  #before_save { self.role ||= :standard }
  after_initialize :init

  def init
    self.role ||= :standard
  end

  enum role: [:standard, :premium, :admin]

  #validates :name, length: {minimum: 1, maximum: 100}, presence: true
end
