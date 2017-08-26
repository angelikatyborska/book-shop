class ApplicationController < ActionController::API
  protected

  def rpc
    Thread.current['rpc'] ||= RpcClient.new(RABBIT_MQ_CONNECTION)
  end
end
