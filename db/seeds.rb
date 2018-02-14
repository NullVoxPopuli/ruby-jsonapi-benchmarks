# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

COMMENTS_PER_POST = 20
POSTS = 20

u = User.create(first_name: 'Diana', last_name: 'Prince', birthday: 3000.years.ago)

POSTS.times do
  p = Post.create(user_id: u.id, title: 'Some Post', body: 'awesome content')

  COMMENTS_PER_POST.times do
    Comment.create(author: 'me', comment: 'nice blog', post_id: p.id)
  end
end
