class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :path
      t.integer :access_count, :default => 0
      
      t.timestamps
    end
  end
end
