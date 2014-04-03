class Cat < ActiveRecord::Base

  validates :name, presence: true

  def self.find_adoptable(id)
    find_by(id: id, adoptable: true)
  end

  def adopted
    self.adoptable = false
    self.save
  end
end
