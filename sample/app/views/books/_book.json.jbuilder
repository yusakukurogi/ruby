json.extract! book, :id, :本の名前, :著者, :出版社, :ページ数, :備考, :created_at, :updated_at
json.url book_url(book, format: :json)