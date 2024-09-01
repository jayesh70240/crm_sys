class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  after_initialize :set_defaults, if: :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: [:admin,:employee]  #0 1 

  has_many :call_logs
  has_many :tasks

  #add role default user when newly created!
  before_save do
    self.role = :user unless ['employee','admin'].include?(self.role)
  end


private
  def set_defaults
    self.status = false if self.status.nil?
  end
end
