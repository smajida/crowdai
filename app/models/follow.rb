class Follow < ApplicationRecord
  belongs_to :followable, polymorphic: true
  belongs_to :participant, optional: true
end
