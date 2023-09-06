# frozen_string_literal: true
require 'rails_helper'

RSpec.describe LearningPath, type: :model do
  let(:valid_attributes) { { name: 'Test Learning Path' } }

  describe 'validations' do
    it 'validates presence of name' do
      learning_path = LearningPath.new(valid_attributes)
      expect(learning_path).to be_valid
    end
  end

  describe 'associations' do
    it 'has and belongs to many talents' do
      talents_association = described_class.reflect_on_association(:talents)
      expect(talents_association.macro).to eq(:has_and_belongs_to_many)
    end

    it 'has many courses' do
      courses_association = described_class.reflect_on_association(:courses)
      expect(courses_association.macro).to eq(:has_many)
      expect(courses_association.options[:inverse_of]).to eq(:learning_path)
    end
  end
end
