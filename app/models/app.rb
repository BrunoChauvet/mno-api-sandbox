# == Schema Information
#
# Table name: apps
#
#  id         :integer          not null, primary key
#  api_token  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  uid        :string(255)
#

class App < ActiveRecord::Base
  attr_accessible :name
  
  #============================================
  # Validation
  #============================================
  validate :name, presence: true
  
  #============================================
  # Callbacks
  #============================================
  after_create :generate_api_token
  after_create :generate_uid
  
  #============================================
  # Associations
  #============================================
  has_many :groups
  has_many :bills, through: :groups
  has_many :recurring_bills, through: :groups
  has_many :users, through: :groups
  
  def self.identify(app_id,api_token,group_id)
    app = self.find_by_uid_and_api_token(app_id,api_token)
    if app.groups.where(uid: group_id).any?
      return app
    else
      return nil
    end
  end
  
  private
    # Intialize the api_token
    def generate_api_token
      if self.id && !self.api_token
        self.api_token = "#{(('a'..'z').to_a + (0..9).to_a).shuffle.join}#{self.id}"
        App.update_all({api_token:self.api_token}, {id: self.id})
      end
      return true
    end
    
    # Initialize the UID and save the record
    def generate_uid
      if self.id && !self.uid
        self.uid = "app-#{self.id}"
        App.update_all({uid:self.uid}, {id: self.id})
      end
      return true
    end
end
