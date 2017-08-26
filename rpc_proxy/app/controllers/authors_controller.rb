class AuthorsController < ApplicationController
  def index
    response = rpc.get('book-shop.books.authors.all')
    render json: response
  end
end
