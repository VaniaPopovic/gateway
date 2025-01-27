# Books API with GraphQL Gateway

This project consists of two parts:

1. An Elixir/Phoenix GraphQL API for managing books
2. A GraphQL Mesh gateway that exposes the Books API

## Prerequisites

- Docker
- Elixir (v1.14 or later)
- Erlang (v24 or later)
- Node.js (v16 or later)
- PostgreSQL (or use Docker)

## Setup Instructions

### 1. Start PostgreSQL Database

bash
docker run --name books-postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres

### 2. Install Elixir (if not installed)

#### macOS

bash
brew install elixir

#### Ubuntu/Debian

bash
wget <https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb>
sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update
sudo apt-get install esl-erlang
sudo apt-get install elixir

#### Windows

Download the installer from: <https://elixir-lang.org/install.html>

### 3. Setup Books API (Phoenix/Elixir)

bash
Install Phoenix project dependencies
cd books_api
mix deps.get

Create and migrate database
mix ecto.create
mix ecto.migrate
Start Phoenix server
mix phx.server

The Books API will be running at:

- GraphQL endpoint: <http://localhost:4000/api/graphql>
- GraphiQL interface: <http://localhost:4000/api/graphiql>

### 4. Setup Gateway (GraphQL Mesh)

bash
Install Node.js dependencies
cd gateway
npm install

Start the gateway in development mode
npm start

The Gateway will be running at:

- GraphQL endpoint: <http://localhost:4001/graphql>

## Testing the API

You can test the API using the GraphiQL interface at <http://localhost:4000/api/graphiql> or through the gateway at <http://localhost:4001/graphql>

Example query:

graphql
{
books {
id
title
author
year
}
}

Example mutation:

graphql
mutation {
createBook(title: "1984", author: "George Orwell", year: 1949) {
id
title
author
year
}
}

## Project Structure

.
├── books_api/ # Phoenix GraphQL API
│ ├── lib/
│ │ ├── books_api/ # Business logic
│ │ └── books_api_web/ # Web layer
│ └── ...
└── gateway/ # GraphQL Mesh Gateway
├── .meshrc.yaml # Mesh configuration
└── index.js # Gateway entry point

## Development

To run both services in development mode:

1. Start PostgreSQL (if using Docker):

bash
docker start books-postgres

2. Start the Phoenix server (in one terminal):

bash
cd books_api
mix phx.server

3. Start the Gateway (in another terminal):

bash
cd gateway
npm start

## Troubleshooting

### Database Connection Issues

- Ensure PostgreSQL is running
- Check database credentials in books_api/config/dev.exs
- Try mix ecto.reset to rebuild the database

### Gateway Connection Issues

- Ensure the Books API is running on port 4000
- Check the endpoint URL in .meshrc.yaml
- Clear the .mesh cache directory and restart the gateway
