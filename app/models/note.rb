class Note < ApplicationRecord
  belongs_to :book
  validates :title, 
    presence: true, 
    length:{maximum: 127}, 
    uniqueness:{ scope: :book_id, case_sensitive: false, message: "title already exists!" }

  def content_as_html
    "<h1>Title: #{title}</h1>"+
      "<br><h3>Content:</h3>"+
      Markdown.new(content).to_html
  end

end
