class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :titre
      t.string :lien
      t.string :tag

      t.timestamps null: false
    end
  end
end
