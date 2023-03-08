require 'database_connection'
require 'book'

class BookRepository
  def all
    sql = 'SELECT id, title, author_name FROM books;'
    result = DatabaseConnection.exec_params(sql, [])

    books_list = []

    result.each do |record|
      book = Book.new
      book.id = record['id']
      book.title = record['title']
      book.author_name = record['author_name']
      
      books_list << record
    end
    return books_list
  end
end