module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
        desc 'Create a book'

        argument :name, required: true, desc: 'Name of the book'

        example [
          '"My book" # Creates a new book named "My book"',
          'Memoires  # Creates a new book named "Memoires"'
        ]

        def call(name:, **)
          begin
            book = Book.new(name)
            ### no chequea si existe
            book.save
            puts "El cuaderno #{name.inspect} fue creado correctamente."
          rescue StandardError => e # Esto es una simplificación, de ser necesario podrías tener manejadores distintos según la excepción
            warn "El cuaderno #{name.inspect} no pudo eliminarse: #{e.message}."
            exit 1
          end
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        example [
          '--global  # Deletes all notes from the global book',
          '"My book" # Deletes a book named "My book" and all of its notes',
          'Memoires  # Deletes a book named "Memoires" and all of its notes'
        ]

        def call(name: nil, **options)
          begin
            global = options[:global]
            book = global ? Book.global : Book.new(name)  
            book.delete
            puts "El cuaderno #{book.name.inspect} fue eliminado junto con su contenido."
          rescue StandardError => e # Esto es una simplificación, de ser necesario podrías tener manejadores distintos según la excepción
            warn "El cuaderno #{book.name.inspect} no pudo eliminarse: #{e.message}."
            exit 1
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]

        def call(*)
          books=Book.all
          puts "Lista de cuadernos:\n"
          books.each {|book| puts "   - #{book.name.inspect}"}
          puts "\n  Total: #{books.size} cuaderno/s."
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]

        def call(old_name:, new_name:, **)
          begin
            book=Book.new(old_name)
            book.rename(new_name)
            puts "El cuaderno #{old_name.inspect} fue renombrado como #{new_name.inspect}."
          rescue StandardError => e # Esto es una simplificación, de ser necesario podrías tener manejadores distintos según la excepción
            warn "No pudo renombrarse el cuaderno #{old_name.inspect} con #{new_name.inspect}: #{e.message}."
            exit 1
          end
        end
      end
    end
  end
end
