class ChronicleBookmark < ActiveRecord::Base
	belongs_to :user
	belongs_to :chronicle
end
