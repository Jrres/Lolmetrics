class AddFieldsToChampion < ActiveRecord::Migration[7.0]
  def change
    add_column :champions, :win, :float
    add_column :champions, :loss, :float
  end
end
