class Component < ActiveRecord::Base
  belongs_to :issue

  # TODO: Validate required attributes
end
