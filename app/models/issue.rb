class Issue < ActiveRecord::Base
  has_many :components
  
  # TODO: Validate required attributes
end
