# lib/rn/paths_helper.rb
module RN
    module PathsHelper

      def root_path
        "#{Dir.home}/.my_rns"
      end
  
      def sanitized_for_filename(string)
        string.gsub(/[^a-z0-9\-]/i, '_') 
      end
  
      def notes_extension
        '.rn'
      end

      def export_extension
        '.html'
      end

      def self.included(base)
        base.extend self
      end
      # ...implementar otros métodos de soporte sobre rutas que consideres necesarios...
    end
  end