# lib/rn/note.rb
module RN
  class Note
    include PathsHelper

    attr_accessor :title, :content, :book
    def self.from_file(path, book: nil)
      title = File.basename(path).chomp(notes_extension)
      content = File.read(path)
      new(title, content, book: book)
    end

    def self.by_title(title, book_name: nil)
      book_name = options[:book_name]
      book = book_name ? Book.new(book_name) : Book.global
      note = book.notes.select {|n| n.title==title}.first
      note
    end
  

    def initialize(title, content, book: nil)
      self.title = title
      self.content = content
      self.book = book || Book.global
    end

    def path
      File.join(book.path,filename)
    end

    def filename
      sanitized_for_filename(title) + notes_extension
    end

    def save
      file = File.new(path, "w")
      file.puts(content)
      file.close
    end

    def delete
      File.delete(path)
    end

    def retitle(new_title)
      old_path=path
      self.title=new_title.dup
      File.rename(old_path,path)
    end

    def export_path
      File.join(File.dirname(path),File.basename(path,notes_extension) + export_extension)
    end


    def export()
      file = File.new(export_path, "w")
      file.puts(Markdown.new(content).to_html) 
      file.close
    end
    # ...implementar el resto de los métodos necesarios para operar con las notas...
  end
end
        


