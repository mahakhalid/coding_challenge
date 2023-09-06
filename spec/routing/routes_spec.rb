# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Routes', type: :routing do

  it 'routes to courses#index' do
    expect(get: '/courses').to route_to('courses#index')
  end

  it 'routes to courses#show' do
    expect(get: '/courses/1').to route_to('courses#show', id: '1')
  end

  it 'routes to courses#new' do
    expect(get: '/courses/new').to route_to('courses#new')
  end

  it 'routes to courses#create' do
    expect(post: '/courses').to route_to('courses#create')
  end

  it 'routes to courses#edit' do
    expect(get: '/courses/1/edit').to route_to('courses#edit', id: '1')
  end

  it 'routes to courses#update' do
    expect(put: '/courses/1').to route_to('courses#update', id: '1')
    expect(patch: '/courses/1').to route_to('courses#update', id: '1')
  end

  it 'routes to courses#destroy' do
    expect(delete: '/courses/1').to route_to('courses#destroy', id: '1')
  end

  it 'routes to authors#index' do
    expect(get: '/authors').to route_to('authors#index')
  end

  it 'routes to authors#show' do
    expect(get: '/authors/1').to route_to('authors#show', id: '1')
  end

  it 'routes to authors#new' do
    expect(get: '/authors/new').to route_to('authors#new')
  end

  it 'routes to authors#create' do
    expect(post: '/authors').to route_to('authors#create')
  end

  it 'routes to authors#edit' do
    expect(get: '/authors/1/edit').to route_to('authors#edit', id: '1')
  end

  it 'routes to authors#update' do
    expect(put: '/authors/1').to route_to('authors#update', id: '1')
    expect(patch: '/authors/1').to route_to('authors#update', id: '1')
  end

  it 'routes to authors#destroy_with_transfer' do
    expect(delete: '/authors/1/destroy_with_transfer').to route_to('authors#destroy_with_transfer', id: '1')
  end

  it 'routes to courses#show' do
    expect(get: '/courses/1').to route_to('courses#show', id: '1')
  end

  it 'routes to courses#new' do
    expect(get: '/courses/new').to route_to('courses#new')
  end

  it 'routes to courses#create' do
    expect(post: '/courses').to route_to('courses#create')
  end

  it 'routes to courses#edit' do
    expect(get: '/courses/1/edit').to route_to('courses#edit', id: '1')
  end

  it 'routes to courses#update' do
    expect(put: '/courses/1').to route_to('courses#update', id: '1')
    expect(patch: '/courses/1').to route_to('courses#update', id: '1')
  end

  it 'routes to courses#destroy' do
    expect(delete: '/courses/1').to route_to('courses#destroy', id: '1')
  end

  it 'routes to courses#mark_completed' do
    expect(post: '/courses/1/mark_completed/2').to route_to('courses#mark_completed', id: '1', talent_id: '2')
  end

  it 'routes to courses#complete_and_assign_next' do
    expect(post: '/courses/1/complete_and_assign_next/2').to route_to('courses#complete_and_assign_next', id: '1', talent_id: '2')
  end

  it 'routes to talents#index' do
    expect(get: '/talents').to route_to('talents#index')
  end

  it 'routes to talents#show' do
    expect(get: '/talents/1').to route_to('talents#show', id: '1')
  end

  it 'routes to talents#new' do
    expect(get: '/talents/new').to route_to('talents#new')
  end

  it 'routes to talents#create' do
    expect(post: '/talents').to route_to('talents#create')
  end

  it 'routes to talents#edit' do
    expect(get: '/talents/1/edit').to route_to('talents#edit', id: '1')
  end

  it 'routes to talents#update' do
    expect(put: '/talents/1').to route_to('talents#update', id: '1')
    expect(patch: '/talents/1').to route_to('talents#update', id: '1')
  end

  it 'routes to talents#destroy' do
    expect(delete: '/talents/1').to route_to('talents#destroy', id: '1')
  end

  it 'routes to learning_paths#index' do
    expect(get: '/learning_paths').to route_to('learning_paths#index')
  end

  it 'routes to learning_paths#show' do
    expect(get: '/learning_paths/1').to route_to('learning_paths#show', id: '1')
  end

  it 'routes to learning_paths#new' do
    expect(get: '/learning_paths/new').to route_to('learning_paths#new')
  end

  it 'routes to learning_paths#create' do
    expect(post: '/learning_paths').to route_to('learning_paths#create')
  end

  it 'routes to learning_paths#edit' do
    expect(get: '/learning_paths/1/edit').to route_to('learning_paths#edit', id: '1')
  end

  it 'routes to learning_paths#update' do
    expect(put: '/learning_paths/1').to route_to('learning_paths#update', id: '1')
    expect(patch: '/learning_paths/1').to route_to('learning_paths#update', id: '1')
  end

  it 'routes to learning_paths#destroy' do
    expect(delete: '/learning_paths/1').to route_to('learning_paths#destroy', id: '1')
  end
end
