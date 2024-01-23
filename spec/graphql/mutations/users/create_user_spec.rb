require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
      describe '.resolve' do
        it 'creates a user' do
          expect do
            post '/graphql', params: { query: query(username: 'user@user.com', email: 'user@email.com') }
          end.to change { User.count }.by(1)
        end

        it 'returns a user' do
          post '/graphql', params: { query: query(username: 'user123', email: 'user@email.com') }
          json = JSON.parse(response.body)

          data = json['data']['createUser']['user']

          expect(data).to include(
            'id' => be_present,
            'username' => 'user123',
            'email' => 'user@email.com'
          )
        end
      end

      def query(username:, email:)
        <<~GQL
          mutation {
            createUser(
              input: {
                username: "#{username}",
                email: "#{email}"
              }
            ) {
              user {
                id
                username
                email
              }
            }
          }
        GQL
      end
    end
  end
end

