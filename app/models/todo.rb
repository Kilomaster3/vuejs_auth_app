class Todo < ApplicationRecord
  include ActiveModel::Serializers::JSON
  belongs_to :user
end
