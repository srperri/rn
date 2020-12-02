module RN
  autoload :VERSION, 'rn/version'
  autoload :Commands, 'rn/commands'
  autoload :PathsHelper, 'rn/paths_helper'
  autoload :Book, 'rn/book'
  autoload :Note, 'rn/note'

  def self.setup
    g_path=Book.global.path
    r_path=File.dirname(g_path)
    Dir.mkdir(r_path) unless Dir.exists?(r_path) 
    Dir.mkdir(g_path) unless Dir.exists?(g_path) 
  end
end