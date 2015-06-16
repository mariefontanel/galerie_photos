class AddAvatarColumnToImages < ActiveRecord::Migration
  def change
    add_attachment :images, :avatar
  end
end
