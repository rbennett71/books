class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  def index
    @books = Book.all
    render status: :ok
  end

  def show
    render json: @book, status: :ok
  end

  def create
    @book = Book.create(book_params)

    if @book.valid?
      render json: @book, status: :created
    else
      render json: @book.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    @book.update(book_params)
    head :no_content
  end

  def destroy
    @book.update(book_params)
    head :no_content
  end

  def book_params
    params.permit(:title, :isbn, :description)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
