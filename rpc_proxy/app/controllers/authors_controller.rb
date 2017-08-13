class AuthorsController < ApplicationController
  def index
    response = ::Rpc.get('book-shop.books.authors.all')
    render json: response
  end
end
