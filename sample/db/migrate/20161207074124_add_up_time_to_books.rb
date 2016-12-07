class AddUpTimeToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :UpTime, :timestamp
  end
end
