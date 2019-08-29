json.array! @books do |book|
  json.id                 book.id
  json.title              book.title
  json.isbn               book.isbn
  json.author_last_name   book.author_last_name
end