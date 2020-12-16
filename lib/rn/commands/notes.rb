module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc 'Create a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Creates a note titled "todo" in the global book',
          '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
          'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book] ? Book.new(options[:book]) : nil
          puts "ingrese el contenido de la nota y 'END' para finalizar"
          content = STDIN.gets("END").chomp("END")
          note = Note.new(title,content,book:book)
          note.save
          puts "La nota #{title.inspect} fue guardada correctamente en el libro #{note.book.name.inspect }"
          #warn "TODO: Implementar creación de la nota con título '#{title}' (en el libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book_name = options[:book]
          book = book_name ? Book.new(book_name) : Book.global
          note = book.note(title)
          note.delete
          puts "La nota #{title.inspect} fue eliminada del libro #{note.book.name.inspect }"
          #warn "TODO: Implementar borrado de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."

        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book_name = options[:book]
          book = book_name ? Book.new(book_name) : Book.global
          note = book.note(title)
          puts "ingrese el nuevo contenido de la nota y 'END' para finalizar"
          note.content=STDIN.gets("END").chomp("END")
          note.save
          puts "Se actualizó el contenido de la nota #{title.inspect} en el libro #{note.book.name.inspect }"
          #warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Retitle < Dry::CLI::Command
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]

        def call(old_title:, new_title:, **options)
          book_name = options[:book]
          book = book_name ? Book.new(book_name) : Book.global
          note = book.note(old_title)
          note.retitle(new_title) 
          puts "El título de la nota #{old_title.inspect} del cuaderno #{note.book.name.inspect} fue cambiado a #{note.title.inspect}"
        rescue SystemCallError => e
          warn "La nota  #{old_title.inspect} no existe: #{e.message}."
          exit 1
        rescue StandardError => e # Esto es una simplificación, de ser necesario podrías tener manejadores distintos según la excepción
          warn "No pudo retitularse la nota  #{old_title.inspect} con #{new_title.inspect}: #{e.message}."
          exit 1
        end
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
          book_name = options[:book]
          global = options[:global]
          books = if global
            [Book.global]
          elsif book_name
            [Book.new(book_name)]
          else
            Book.all
          end
          books.each do |book|
            puts ">#{book.name}"
            book.notes.each {|note| puts "    >#{note.title}"}
          end
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          book_name = options[:book]
          book = book_name ? Book.new(book_name) : Book.global
          note = book.note(title)
          puts "Titulo: #{note.title}"
          puts "#{note.content}" 
        end
      end

      class Export < Dry::CLI::Command
        desc 'Export a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          book_name = options[:book]
          book = book_name ? Book.new(book_name) : Book.global
          note = book.note(title)
          note.export
        end
      end
    end
  end
end
