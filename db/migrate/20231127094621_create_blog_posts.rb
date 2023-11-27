class CreateBlogPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :summary
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.string :title_image_url

      t.timestamps
    end
  end
end
