class BooksController < ApplicationController
  def index
    response = rpc.get('book-shop.books.books.all')
    render json: response
  end
end
