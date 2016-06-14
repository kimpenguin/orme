class Category < ActiveRecord::Base
	has_many :stack_categories
	has_many :stacks, through: :stack_categories
	has_many :chroniclecategories
	has_many :chronicles, through: :chronicle_categories

end
