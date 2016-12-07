class AddTimeToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :Time, :timestamp
  end
end
