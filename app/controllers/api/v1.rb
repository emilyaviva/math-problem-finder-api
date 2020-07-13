module Api::V1
  class UnprocessableMappingError < StandardError
    def initialize(message="Unprocessable mapping between lessons and tasks")
      super
    end
  end
end
