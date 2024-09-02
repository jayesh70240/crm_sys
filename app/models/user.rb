class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  after_initialize :set_defaults, if: :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: [:admin,:employee]  #0 1 

  has_many :tasks, dependent: :destroy
  has_many :call_logs, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  #add role default user when newly created!
  before_save do
    self.role = :employee unless ['admin'].include?(self.role)
  end


private
  def set_defaults
    self.status = false if self.status.nil?
  end
end
