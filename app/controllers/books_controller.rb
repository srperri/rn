class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :list_notes, :download]

  include FilenameHelper
  
  # GET /books
  def index
    @books = current_user.books 
  end
  
  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = current_user.books.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = current_user.books.new(book_params)
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

  # DOWNLOAD /book/1/download
  def download 
    send_data book_as_zip(@book).string,
        filename: "#{sanitized_for_filename(@book.title)}.zip",
        type: "application/zip"
  end

  # DOWNLOAD /books/download_all
  def download_all 
    send_data books_as_zip(current_user.books).string,
        filename: "all_books.zip",
        type: "application/zip"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = current_user.books.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title)
    end

    def book_as_zip(book)
      Zip::OutputStream.write_buffer do |stream|
        book.notes.each do |note|
          # add note to zip
          stream.put_next_entry("#{sanitized_for_filename(note.title)}.html")
          stream.write note.content_as_html.html_safe
        end  
      end
    end

    def books_as_zip(books)
      Zip::OutputStream.write_buffer do |stream|
        books.each do |book|
          book.notes.each do |note|
            # add note to zip
            stream.put_next_entry("#{sanitized_for_filename(book.title)}/#{sanitized_for_filename(note.title)}.html")
            stream.write note.content_as_html.html_safe
          end
        end  
      end
    end

  end
