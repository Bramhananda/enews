class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  attr_accessible  :email, :password, :password_confirmation, :remember_me, :name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  #validates :name, presence: true


end
