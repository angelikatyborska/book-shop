class Book < ActiveRecord::Base
  belongs_to :author
  # TODO: validations
end
