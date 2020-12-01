# lib/rn/note.rb
module RN
    class Note
      include PathsHelper
  
      attr_accessor :title, :content, :book
      def self.from_file(path, book: nil)
        title = File.basename(path)
        content = File.read(path)
        new(title, content, book: book)
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
        #sanitize_for_filename(title) + notes_extension
        title + notes_extension
      end
  
      def save
        file = File.new(path, "w")
        file.puts(self.content)
        file.close
        # TODO: Acá se crea / actualiza el archivo asociado a la nota (cuya ruta se obtiene con #path)
      end

      def delete
        File.delete(path)
        # TODO: Acá se crea / actualiza el archivo asociado a la nota (cuya ruta se obtiene con #path)
      end
  
      # ...implementar el resto de los métodos necesarios para operar con las notas...
    end
  end
        


