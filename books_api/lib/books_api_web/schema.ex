defmodule BooksApiWeb.Schema do
  use Absinthe.Schema

  object :book do
    field :id, :id
    field :title, :string
    field :author, :string
    field :year, :integer
  end

  query do
    field :books, list_of(:book) do
      resolve fn _parent, _args, _resolution ->
        {:ok, BooksApi.Books.list_books()}
      end
    end

    field :book, :book do
      arg :id, non_null(:id)
      resolve fn _parent, %{id: id}, _resolution ->
        {:ok, BooksApi.Books.get_book!(id)}
      end
    end
  end

  mutation do
    field :create_book, :book do
      arg :title, non_null(:string)
      arg :author, non_null(:string)
      arg :year, non_null(:integer)

      resolve fn _parent, args, _resolution ->
        BooksApi.Books.create_book(args)
      end
    end

    field :update_book, :book do
      arg :id, non_null(:id)
      arg :title, :string
      arg :author, :string
      arg :year, :integer

      resolve fn _parent, %{id: id} = args, _resolution ->
        book = BooksApi.Books.get_book!(id)
        args = Map.delete(args, :id)
        BooksApi.Books.update_book(book, args)
      end
    end

    field :delete_book, :book do
      arg :id, non_null(:id)

      resolve fn _parent, %{id: id}, _resolution ->
        book = BooksApi.Books.get_book!(id)
        BooksApi.Books.delete_book(book)
      end
    end
  end
end
