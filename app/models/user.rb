class User < ApplicationRecord
  attr_accessor :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, 
  :omniauthable, omniauth_providers: %i[facebook]
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, 
  default_url: "/assets/Random-turtle.gif",
  :url  => "/assets/images/:id/:style/:basename.:extension",
   :path => ":rails_root/public/assets/images/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

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