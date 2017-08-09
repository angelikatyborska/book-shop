# Book Shop

Just a little something to practice my skills in various technologies. Nothing interesting to see here.

What I want to try:
- using MongoDB in an Elixir app,
- using ActiveRecord without Rails,
- setting up a few apps communicating via RabbitMQ,
- setting up a stack of more than 2 apps with docker-compose,

It's not like it's something super interesting or difficult, it's just I have never done this on my own.

1. Books

A Ruby service listing books (AMQP, PostgreSQL).

2. Reviews

An Elixir service providing reviews, including reviews of books (AMQP, MongoDB)

3. HTTP Server

A Ruby On Rails API that reroutes external HTTP request to internal RabbitMQ requests.

