json.array! @books do |book|
  json.id     book.id
  json.title  book.title
  json.isbn   book.isbn
end