module Moyskladsync
  module Clients
    class Gdrive
      def initialize(secret_json, spreadsheet_id)
        @secret_json = secret_json
        @spreadsheet_id = spreadsheet_id
      end

      def add_product(product)
        worksheet.insert_rows(
          worksheet.num_rows + 1,
          [[product.full_name]]
        )
      end

      def save
        worksheet.save
      end

      def clear
        worksheet.delete_rows(1, worksheet.num_rows)
      end

      private

      def worksheet
        @_worksheet ||= begin
          session = GoogleDrive::Session.from_service_account_key(secret_json)
          session.spreadsheet_by_key(spreadsheet_id).worksheets.first
        end
      end

      attr_reader :secret_json, :spreadsheet_id
    end
  end
end
