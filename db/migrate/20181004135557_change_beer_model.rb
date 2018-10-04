class ChangeBeerModel < ActiveRecord::Migration[5.2]
  def change
    change_table :beers do |t|
      t.rename :style, :old_style
      t.integer :style_id
    end
  end
end
