require 'rap/vendor/zip/zipfilesystem'

module Rap
  module Package
    class Validator

      attr_reader :package_name
      attr_reader :errors

      def initialize(package_name)
        @package_name = package_name

        @errors       = []
        @did_validate = false
      end

      def validate!
        @did_validate = true

      end

      def valid?
        validate_if_necessary

        errors.empty?
      end


      protected

      def validate_if_necessary
        validate! unless @did_validate
      rescue ValidationFailed
        # bury, we don't care about raising errors here
      end

    end

    class ValidationFailed < StandardError; end

  end
end