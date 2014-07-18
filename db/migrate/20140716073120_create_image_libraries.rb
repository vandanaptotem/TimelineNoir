class CreateImageLibraries < ActiveRecord::Migration
  def change
    create_table :image_libraries do |t|
      t.attachment :image
      t.attachment :file
      t.timestamps
    end
  end
end
