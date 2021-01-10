class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :list_notes]

  # GET /books
  def index
    @books = current_user.books  #Book.where(user_id: current_user) # Book.all
  end
  
  # GET /books/list_all_notes
  def list_all_notes
    @books = current_user.books  #Book.where(user_id: current_user) # Book.all
  end

  # GET /books/1/list_notes
  def list_notes
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = current_user.books.new
    #@book = Book.new
    #@book.user_id = current_user
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = current_user.books.new(book_params)
    #@book = Book.new(book_params)
    #@book.user_id = current_user.id

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    if @book.global?
      @book.clear
      redirect_to books_url, notice: 'Global book was successfully cleared.'
    else
      @book.destroy
      redirect_to books_url, notice: 'Book was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = current_user.books.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      #params.require(:book).permit(:user_id, :title)
      params.require(:book).permit(:title)
    end
end
