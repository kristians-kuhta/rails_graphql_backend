# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    argument :username, String, required: true
    argument :email, String, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(username: nil, email: nil)
      user = User.new(username: username, email: email)

      user.save

      {
        user: user.persisted? ? user : nil,
        errors: user.errors.full_messages
      }
    end
  end
end
