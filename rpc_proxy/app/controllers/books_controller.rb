class BooksController < ApplicationController
  def index
    response = ::Rpc.get('book-shop.books.books.all')
    render json: response
  end
end
