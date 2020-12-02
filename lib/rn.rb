module RN
  autoload :VERSION, 'rn/version'
  autoload :Commands, 'rn/commands'
  autoload :PathsHelper, 'rn/paths_helper'
  autoload :Book, 'rn/book'
  autoload :Note, 'rn/note'

  def self.setup
    global_book=Book.global
    Dir.mkdir(global_book.root_path) unless Dir.exists?(global_book.root_path) 
    Dir.mkdir(global_book.path) unless Dir.exists?(global_book.path) 
  end
end