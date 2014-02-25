class Athlete < ActiveRecord::Base
	validates :first_name, presence: { message: 'must be present.' }
	validates :age, numericality: { greater_than_or_equal_to: 14 }

	def name
		"#{first_name} #{last_name}".split.join(' ')
	end

	def full_name
	end
end
