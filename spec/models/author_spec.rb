# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      author = Author.new(name: 'Test Author')
      expect(author).to be_valid
    end

    it 'is invalid without a name' do
      author = Author.new(name: nil)
      author.valid?
      expect(author.errors[:name]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'has many authored_courses' do
      author = Author.reflect_on_association(:authored_courses)
      expect(author.macro).to eq(:has_many)
      expect(author.options[:class_name]).to eq('Course')
      expect(author.options[:foreign_key]).to eq('author_id')
    end
  end
end
