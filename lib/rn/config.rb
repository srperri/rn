module RN
    module Config
        def self.initial_dir
            Dir.home() +"/.my_rns"
        end
    end
end