class ContainerInstance < ActiveRecord::Base
  belongs_to :docker_configuration
  has_many :container_logs, dependent: :destroy

  as_enum :status, [:initialized, :built, :started, :error, :deleted], map: :string
end