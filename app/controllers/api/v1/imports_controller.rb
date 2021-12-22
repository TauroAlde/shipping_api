module Api
  module V1
    class ImportsController < ApplicationController
      before_action :authorize_request!
      require 'securerandom'
      require 'charlock_holmes/string'

      api :POST, '/imports',"Import document"
      formats ['form-data']
      returns code: 200, desc: 'OK'
      error 401, 'Unauthorized'
      param :shipments_data, ActionDispatch::Http::UploadedFile, required: true ,:desc => "Need to set a CSV file in form-data"
      description <<-EOS
        == Description
          Import file csv
        EOS
      def create
        csv_text = File.read(set_import_params)
        format_document = CharlockHolmes::EncodingDetector.detect(csv_text)

        if format_document[:encoding] == "UTF-8"

          case File.extname(set_import_params.original_filename)
          when ".csv"
            records = Services::ConvertToArray.call(csv_text)
            uuid = SecureRandom.uuid

            import_detail = ImportDetail.create(
              uuid: uuid,
              headers: records.first.keys.to_json,
              data: records.to_json,
              status: ImportDetail::PENDING,
            )
            Workers::ImporterWorker.perform_async(uuid)

            render json: { id: import_detail.uuid }, status: :ok
          when "another format" 
            "for more extensions"
          else
            render json: { message: "Format not supported" }, status: :bad_request
          end
        else
          render json: { message: "Format not supported" }, status: :bad_request
        end
      end

      private

      def set_import_params
        params
          .require(
            :shipments_data
          )
      end
    end
  end
end
