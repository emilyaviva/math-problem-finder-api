module Api
  module V1
    # Custom error for handling bad many-many mappings
    class UnprocessableMappingError < StandardError
      def initialize(message = "Unprocessable mapping between lessons and tasks")
        super
      end
    end
  end
end
