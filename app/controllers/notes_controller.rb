class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy, :download]
  before_action :set_book , except: [:create]

  include ApplicationHelper
  # GET /notes/1
  def show
  end 

  # GET /notes/new
  def new
    @note = @book.notes.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    @book = current_user.books.find(note_params[:book_id])
    @note = @book.notes.new(note_params)

    if @note.save
      redirect_to @note, notice: 'Note was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      redirect_to @note, notice: 'Note was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
    redirect_to @book, notice: 'Note was successfully destroyed.'
  end

  # DOWNLOAD /notes/1/download
  def download 
    send_data @note.content_as_html.html_safe, 
              filename: "#{sanitized_for_filename(@note.title)}.html",
              type: "application/text"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = current_user.books.find(params[:book_id]||@note.book_id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = current_user.notes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:book_id, :title, :content)
    end

    

end
