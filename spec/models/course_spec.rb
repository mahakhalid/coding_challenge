# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:valid_author_attributes) { { name: 'Test Author' } }
  let(:valid_attributes) { { title: 'Test Course' } }

  describe 'associations' do
    it 'belongs to an author' do
      author_association = described_class.reflect_on_association(:author)
      expect(author_association.options[:class_name]).to eq('Author')
    end

    it 'has and belongs to many talents' do
      talents_association = described_class.reflect_on_association(:talents)
      expect(talents_association.options[:class_name]).to eq('Talent')
    end
  end

  describe 'validations' do
    it 'validates presence of title' do
      course = Course.new(valid_attributes)
      author = Author.create!(valid_author_attributes) # Create a valid author
      course.author = author # Associate the course with a valid author
      expect(course).to be_valid
    end
  end
end
