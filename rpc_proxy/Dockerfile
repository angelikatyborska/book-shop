FROM ruby:2.4.1

RUN adduser --disabled-password --system rpc_proxy

WORKDIR /home/rpc_proxy/

COPY Gemfile Gemfile.lock /home/rpc_proxy/
RUN bundle install

COPY . /home/rpc_proxy/
RUN chown -R rpc_proxy /home/rpc_proxy/
USER rpc_proxy

CMD ["/home/rpc_proxy/CMD.sh"]
