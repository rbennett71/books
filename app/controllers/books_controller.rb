class BooksController < ApplicationController
  include Orderable
  before_action :set_book, only: [:show, :update, :destroy]

  has_scope :by_author, only: :index

  def index
    @books = apply_scopes(Book).order(ordering_params(params)).all
    render   status: :ok
  end

  def show
    render status: :ok
  end

  def create
    @book = Book.create(book_params)

    if @book.valid?
      render status: :created
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
    params.permit(:title, :isbn, :description, :author_last_name)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end

#@todo - Coverage on main controller actions
# todo - Get a good exception handler in here
#