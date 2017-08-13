class Author < ActiveRecord::Base
  has_many :books, dependent: :destroy
  # TODO: validations

  default_scope { includes(:books) }

  def book_count
    books.length # .count causes a SELECT COUNT(*) database query
  end

  def attributes
    super.merge(book_count: book_count)
  end
end
