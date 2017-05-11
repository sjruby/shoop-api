require 'rails_helper'

RSpec.describe 'Boards', type: :request do


# this here is the test user that will be used for authentication
  def user_params
    {
      email: 'alice@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    }
  end

 # THIS IS WHERE THE AUTHENTICATED TESTS START
# All Board actions require you to be signed in, so add this authenticaton logic
  context 'when authenticated' do
  def headers
    {
      'HTTP_AUTHORIZATION' => "Token token=#{@token}"
    }
  end
  # This sets the definition of a board for us
   def board_params
   # parameters for creating a board
   {
     title: 'New Board',
     cells: 'TEST'
   }
   end

  # this creates the fake users AND a fake board using the POST action below
  # this was killer b/c of the header
  before(:each) do
    post '/sign-up', params: { credentials: user_params }
    post '/sign-in', params: { credentials: user_params }

    @token = JSON.parse(response.body)['user']['token']
    @user_id = JSON.parse(response.body)['user']['id']
    post '/boards', params: { boards: board_params },  headers: headers
  end
# I couldn't figure out how to pass the header into this guy below so
# I created it above in the before each, then this selects the first for testing
  def board
    Board.first
  end
 # this is the list of boards used for testing
   def boards
     # returns a list of all boards
     Board.all
   end

  describe 'GET /list-boards' do
    it 'lists all boards' do
      # Make the request
      get '/list-boards', headers: headers
      # Expect the request to be a response
      expect(response).to be_success
      # Pull the response from server
      boards_response = JSON.parse(response.body)
      # check that the response matches the list of boards created above
      expect(boards_response.length).to eq(boards.count)
      # fcheck that the response matches what was fed into database
      expect(boards_response['title']).to eq(board_params['title'])
    end
  end

  describe 'GET /boards/:id' do
    it "shows the board" do
      get "/boards/#{board.id}", headers: headers

      expect(response).to be_success
      # Pull the response from server
      board_response = JSON.parse(response.body)

      expect(board_response['title']).to eq(board_params['title'])
    end
  end

  describe 'DELETE /boards/:id' do
    it "deletes a board" do
      delete "/boards/#{board.id}", headers: headers

      expect(response).to be_success
      expect(response.body).to be_empty
      expect(board).to be_nil
    end
  end

  describe 'PATCH /boards/:id' do
    # this creates the data we're gonna try to patch into the data base
    def board_updated
      {title:"ITS UPDATED"}
    end

    # This tests the article with the patch
    it "updates a board" do
      patch "/boards/#{board.id}", params: {board: board_updated}, headers: headers
      expect(response).to be_success
      expect(board['title']).to eq(board_updated['title'])

    end
    end

    describe 'POST/boards' do
      def new_board
        {title:"ITS NEW",
         cells:"IMA here"}
      end

      it "creates a new board" do
        post "/boards", params: {board: new_board}, headers: headers

        expect(response).to be_success

        board_response = JSON.parse(response.body)
        expect(board_response['title']).to eq(new_board['title'])
      end
    end
  end

  context 'when NOT authenticated' do

   describe 'GET /list-boards' do
     it 'is not sucessful' do
       # Make the request
       get '/list-boards'
       # Expect the request to be a response
       expect(response).to_not be_success
     end
   end


  end
end
