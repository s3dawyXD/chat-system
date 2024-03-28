class Application < ApplicationRecord
  self.primary_key = 'id'
  has_many :chats
  before_create :generate_uuid

  def generate_uuid
    self.id = SecureRandom.uuid
  end
end
