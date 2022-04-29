class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  
  has_secure_password
  
  field :first_name, type: String
  field :last_name, type: String
  field :email_id, type: String
  field :phone_no, type: String
  field :password_digest, type: String
  field :confirmation_token, type: String
  field :confirmed_at, type: DateTime
  field :confirmation_sent_at, type: DateTime
  field :reset_password_token, type: String
  field :reset_password_token_expires_at, type: DateTime

  validates :first_name, :presence => true,
                        :length => { minimum: 3 }
  validates :last_name, :presence => true,
                        :length => { minimum: 3 }
  validates :password, :presence => true,
                       :length => { minimum: 6 }
  validates :email_id, :presence => true,
                        :format => { with: URI::MailTo::EMAIL_REGEXP } 
  validates :phone_no, :presence => true,
                       :length => { :minimum => 10, :maximum => 15 }

  before_save :downcase_email

  before_create :generate_confirmation_instructions
   
  def downcase_email
    self.email_id = self.email_id.delete(' ').downcase
  end

  def generate_confirmation_instructions
    self.confirmation_token   = SecureRandom.hex(10)
    self.confirmation_sent_at = Time.now.utc
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.update_attribute(:confirmed_at , Time.now.utc)
  end

  def generate_token_for_password_reset!
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.reset_password_token_expires_at = 1.day.from_now
    save
  end

  def clear_password_token!
    self.reset_password_token = nil
    self.reset_password_token_expires_at = nil
    save
  end
end
