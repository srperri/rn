# lib/rn/book.rb
module RN
    class Book
      GLOBAL_BOOK_NAME = '__global__'
  
      include PathsHelper
  
      attr_accessor :name
  
      def self.global
        new GLOBAL_BOOK_NAME
      end
  
      def self.from_directory(path)
        new File.basename(path)
      end
  
      def self.all
        found = Dir["#{Book.global.root_path}/*"].select { |e| File.directory?(e) }.map do |book_path|
          Book.from_directory(book_path)
        end
        # Se fuerza la inclusión del cuaderno global en caso que aún no exista
        found.unshift(Book.global) unless found.any?(&:global?)
        found
      end

      def initialize(name)
        self.name = name
      end
  
      def global?
        name == GLOBAL_BOOK_NAME
      end
  
      def notes
        Dir["#{path}/*#{notes_extension}"].map do |note_path|
          Note.from_file(note_path, book: self)
        end
      end
  
      def note(title)
        note_path="#{path}/#{title}#{notes_extension}"
        Note.from_file(note_path, book: self)
      end
  
      def path
        "#{root_path}/#{self.name}"
      end
  
      def save
        FileUtils.mkdir_p path
      end

      def rename(name)
        old_path=path
        self.name=name
        File.rename(old_path,path)
      end

      def delete
        notes.each {|note| note.delete}
        File.delete(path) unless global?
      end

    end
  end