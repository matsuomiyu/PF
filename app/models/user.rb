class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :profile_image
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def guest_login
    # ゲストカラムをtrueに設定することで、ゲストログインユーザーとして認識します
    update(guest: true)
  end
  
  #検索
  def self.search(keyword, exact_match = true)
    if exact_match
      where(name: keyword)
    else
      where("name LIKE ?", "%#{keyword}%")
    end
  end
  
end
