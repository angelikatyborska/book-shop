class Books
  def initialize
    @logger = Logger.new(STDOUT)
  end

  def hello
    @logger.info('Hello World, we are going to read some books')
  end
end
