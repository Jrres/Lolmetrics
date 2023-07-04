class CreateChampions < ActiveRecord::Migration[7.0]
  def change
    create_table :champions do |t|
      t.text :name
      t.float :win
      t.float :loss  
      t.text :firstrune
      t.text :secondrune
      t.text :thirdrune
      t.text :fourthrune

      t.timestamps
    end
  end
end
