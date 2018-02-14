class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table 'comments', force: :cascade do |t|
      t.integer 'post_id'
      t.string 'author'
      t.string 'comment'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['post_id'], name: 'index_comments_on_post_id'
    end

    create_table 'posts', force: :cascade do |t|
      t.integer 'user_id'
      t.string 'title'
      t.string 'body'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['user_id'], name: 'index_posts_on_user_id'
    end

    create_table 'users', force: :cascade do |t|
      t.string 'first_name'
      t.string 'last_name'
      t.datetime 'birthday'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end
  end
end
