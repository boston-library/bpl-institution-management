class Institution < ActiveRecord::Base
  has_and_belongs_to_many :users

  #attr_accessible :pid, :name

  validates :name,
    uniqueness: true,
    format: { with: /\A[a-zA-Z0-9._ -]+\z/,
      :message => "Only letters, numbers, hyphens, underscores, spaces and periods are allowed"}

end
