FROM ruby:2.4.1

RUN adduser --disabled-password --system books

WORKDIR /home/books/

COPY Gemfile Gemfile.lock /home/books/
RUN bundle install

COPY . /home/books/
RUN chown -R books /home/books/
USER books

CMD ["/home/books/CMD.sh"]
