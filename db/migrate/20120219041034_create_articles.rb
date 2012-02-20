class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string   :title,   null: false
      t.string   :slug,    null: false
      t.text     :summary, null: false
      t.text     :content, null: false

      t.timestamps
    end
  end
end
