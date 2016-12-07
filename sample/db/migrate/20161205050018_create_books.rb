class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :本の名前
      t.string :著者
      t.string :出版社
      t.integer :ページ数
      t.text :備考

      t.timestamps
    end
  end
end
