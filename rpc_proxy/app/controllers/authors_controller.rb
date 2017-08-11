class AuthorsController < ApplicationController
  def index
    response = ::Rpc.get('book-shop.books.authors.list')
    render json: response
  end
end
