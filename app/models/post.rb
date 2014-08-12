class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  scope :angry, ->{where(anger:true)}
  scope :calm, ->{where(anger:false)}

validates :title, presence: true
validates :body, presence: true

end
