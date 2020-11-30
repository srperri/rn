module RN
  autoload :VERSION, 'rn/version'
  autoload :Commands, 'rn/commands'
  autoload :PathsHelper, 'rn/paths_helper'
  autoload :Book, 'rn/book'
  autoload :Note, 'rn/note'
  # autoload :Config, 'rn/config'

  # require 'rn/config'

  # Agregar aquí cualquier autoload que sea necesario para que se cargue las clases y
  # módulos del modelo de datos.
  # Por ejemplo:
  # autoload :Note, 'rn/note'
end
# module Config
#   def self.initial_dir
#       Dir.home() +"/.my_rns"
#   end
# end