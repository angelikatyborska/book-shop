# Book Shop

Just a small "playground" project to practice my skills in various technologies. Nothing interesting to see here.

What I want to try:
- using MongoDB in an Elixir app,
- using ActiveRecord without Rails,
- setting up a few apps communicating via RabbitMQ,
- setting up a stack of more than 2 apps with docker-compose,

## Setup

1. `docker volume create --name=postgres_data`
2. `docker-compose up -d`
3. `docker-compose exec books bash` -> `bin/setup`
4. `docker-compose exec rpc_proxy bash` -> `bin/setup`
5. `docker-compose down`
6. `docker-compose up -d`

## What's up

1. Books

A Ruby service listing books (RabbitMQ + Bunny, PostgreSQL).

2. Reviews

An Elixir service providing reviews, including reviews of books (RabbitMQ, MongoDB)

3. Rpc Proxy

A HTTP Server that translates external HTTP request to internal RabbitMQ RPCs (Ruby on Rails, RabbitMQ + Bunny).

