# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do |i|
    User.create! email: "user#{i}@ruby.edu", password: "rnuser##{i}", password_confirmation: "rnuser##{i}"
end

users=User.all

users.each_with_index { |user,i|
    p user.email
    user.global_book.notes.create!(title: "note assorted", content: "I'm in the global book!")
    (4-(user.id)).times do |j|
        p "   book ##{j} of #{user.email}"
        book = user.books.create!(title: "book ##{j}")
        5.times do |k|
            book.notes.create!(title: "note ##{k}", content: "content accepting **Markdown**  of note ##{k}")
        end
        book.notes.create!(title: "note #6", content: "# contenido con imágenes  ![](https://logo.clearbit.com/rubyonrails.org)  ![titulo](http://www.ruby-lang.org/images/header-ruby-logo.png)  ")

    end
}
  