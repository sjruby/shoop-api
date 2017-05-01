class Board < ApplicationRecord
  serialize :cells
  belongs_to :user
end
