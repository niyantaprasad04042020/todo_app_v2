class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  
  has_secure_password
  
  field :first_name, type: String
  field :last_name, type: String
  field :email_id, type: String
  field :phone_no, type: String
  field :password_digest, type: String
  validates :first_name, presence: true, length: { minimum: 6 }
  validates :last_name, presence: true, length: { minimum: 6 }
  validates :password, length: { minimum: 6 }
  validates :email_id, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :phone_no,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 15 }

end
