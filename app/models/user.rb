class User < ApplicationRecord
  attr_accessor :photo
  
  has_and_belongs_to_many :tournois, class_name: 'Tournament'
  has_many :created_tournaments, class_name: 'Tournament'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, 
  :omniauthable, omniauth_providers: %i[facebook]
   has_attached_file :photo,
                       styles: { medium: "100x100>", thumb: "150x150>" },
                       default_url: "/assets/missing.jpeg"
    validates_attachment :photo,
                        content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                        size: { in: 0..5.megabytes },
                        s3_permissions: :private
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  validates :username,  presence: true, 
                        uniqueness: { case_sensitive: false }

  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  		user.email = auth.info.email
  		user.password = Devise.friendly_token[0,20]
  	end
  end

  private

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end