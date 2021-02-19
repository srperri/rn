module FilenameHelper
    def sanitized_for_filename(string)
        string.gsub(/[^a-z0-9\-]/i, '_') 
    end
end
