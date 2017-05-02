require 'rails_helper'

RSpec.describe 'routes for boards' do
  it 'routes GET /boards to the boards#index action' do
    # check that a get request to /boards routes to the index method
    # of the boards controller
    expect(get('/boards')).to route_to('boards#index')
  end

  it 'routes GET /boards/:id to the boards#show action' do
    expect(get('boards/1')).to route_to(
        controller: 'boards',
        action: 'show',
        id: '1'
    )
  end

  it 'routes DELETE /boards/:id to the boards#destroy action' do
    expect(delete('boards/1')).to route_to(
      controller: 'boards',
      action: 'destroy',
      id: '1'
    )
  end

  it 'routes PATCH /boards/:id to the boards#update action' do
    expect(patch('/boards/1')).to route_to(
      controller: 'boards',
      action: 'update',
      id: '1'
    )
  end

  it 'routes POST /boards to the boards#create action' do
    expect(post('/boards')).to route_to(
      controller: 'boards',
      action: 'create'
    )
  end
end
