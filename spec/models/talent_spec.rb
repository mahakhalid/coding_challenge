# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Talent, type: :model do
  let(:valid_attributes) { { name: 'Test Talent' } }

  describe 'validations' do
    it 'validates presence of name' do
      talent = Talent.new(valid_attributes)
      expect(talent).to be_valid
    end
  end

  describe 'associations' do
    it 'has and belongs to many courses' do
      courses_association = described_class.reflect_on_association(:courses)
      expect(courses_association.macro).to eq(:has_and_belongs_to_many)
    end

    it 'has and belongs to many learning_paths' do
      learning_paths_association = described_class.reflect_on_association(:learning_paths)
      expect(learning_paths_association.macro).to eq(:has_and_belongs_to_many)
    end

    it 'has many authored_courses' do
      authored_courses_association = described_class.reflect_on_association(:authored_courses)
      expect(authored_courses_association.macro).to eq(:has_many)
      expect(authored_courses_association.options[:class_name]).to eq('Course')
      expect(authored_courses_association.options[:foreign_key]).to eq('author_id')
    end
  end
end
