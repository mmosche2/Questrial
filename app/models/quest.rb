class Quest < ActiveRecord::Base
	validates :title, :presence => true,
					  :length => { :minimum => 5 }
					  
	has_many :comments, :dependent => :destroy
	
	has_attached_file :photo,
		:styles => { :thumb => "50x50#",
					 :small => "100x100>",
					 :original => "150x150>" },
		:default_url => '/system/photos/missing_:style.png'
					 
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']	
end
