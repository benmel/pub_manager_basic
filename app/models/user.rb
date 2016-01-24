class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :projects, inverse_of: :user, dependent: :destroy
  has_many :templates, inverse_of: :user, dependent: :destroy
  has_many :books, through: :projects
end
