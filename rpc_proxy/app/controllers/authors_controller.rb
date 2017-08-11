class AuthorsController < ApplicationController
  def index
    response = ::RpcClient.get('book-shop.books.authors.list')
    puts 'got response'
    puts response
    render json: response
  end
end