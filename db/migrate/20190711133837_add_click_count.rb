class AddClickCount < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :click_count, :integer
  end

end
