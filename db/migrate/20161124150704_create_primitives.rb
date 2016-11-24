class CreatePrimitives < ActiveRecord::Migration[5.0]
  def change
    create_table :primitives do |t|
      t.string :name_uri
      t.string :property
      t.string :method
      t.string :arguments
      t.string :btn_label

      t.timestamps
    end
  end
end
