require 'spec_helper'

describe Athlete do
	before :all do
		@valid_attributes = {
			first_name: 'Shaun',
			middle_name: 'Roger',
			last_name: 'White',
			age: 27,
			sport: 'Shredding',
			country: 'USA'
		}
	end

	describe '#name' do
		context 'when first and last name are present' do
			it 'returns the first and last names concatenated with space in between' do
				expect(Athlete.new(first_name: 'Jorge', last_name: 'Middleton').name).to eq 'Jorge Middleton'
				expect(Athlete.new(first_name: 'Justin', last_name: 'Bieber').name).to eq 'Justin Bieber'
			end
		end

		context 'when first name is nil and last_name is present' do
			it 'returns just the last name' do
				expect(Athlete.new(last_name: 'Smith').name).to eq 'Smith'
			end
		end

		context 'when last name is nil and first name is present' do
			it 'returns just the first name' do
				expect(Athlete.new(first_name: 'Jim').name).to eq 'Jim'
			end
		end

		context 'when first and last names are nil' do
			it 'returns an empty string' do
				expect(Athlete.new.name).to eq ''
			end
		end
	end

	describe '#full_name' do
		context 'when middle name is blank' do
		end

		context 'when middle name is present' do
		end
	end

	describe 'validations' do
		context 'when all attributes are valid' do
			it 'the record is valid' do
				expect(Athlete.new(@valid_attributes)).to be_valid
			end
		end

		context 'when first_name is missing' do
			it 'the record is not valid' do
				athlete = Athlete.new(@valid_attributes.merge(first_name: ''))
				# athlete = Athlete.new(@valid_attributes)
				# athelete.first_name = ''
				expect(athlete).not_to be_valid
				# expect(athlete).to be_invalid
				# expect(athlete.valid?).to eq false
				expect(athlete.errors[:first_name]).to include "must be present."
			end
		end

		context 'when age is less than 14' do
			it 'the record is not valid' do
				athlete = Athlete.new(@valid_attributes)
				athlete.age = 13.999999
				expect(athlete).to be_invalid
			end
		end
	end
end

# When age is non-numeric, it should not be valid.
# When age is less than 14, it should not be valid.
# When country is not in the list, it should not be valid.  ** List is 
#      ['USA', 'Canada', 'Russia', 'China', 'Jamaica', 'Iran']


# I want a method called #full_name, which prints out the first and middle
#      and last names together.
# Given first: 'John', middle: 'Nathan', last: 'Lawrence', I want
#     John Nathan Lawrence

# Given a blank middle name, I do not want "John  Lawrence"



