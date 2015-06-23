class Image < ActiveRecord::Base
  validates :titre, :tag, presence: true
  
  has_attached_file :avatar, :styles => { :medium => "300x200!", :thumb => "100x66!" }, :default_url => "/images/:style/missing.png"
  validates_attachment :avatar, :presence => true, :content_type => { :content_type => ["image/jpeg", "image/png", "image/gif", "image/svg"] }, :size => { :in => 0..5.megabytes }
end
