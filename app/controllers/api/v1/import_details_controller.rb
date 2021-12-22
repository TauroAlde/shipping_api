module Api
  module V1
    class ImportDetailsController < ApplicationController
      before_action :authorize_request!

      api :POST, '/import_details',"Details for import"
      formats ['json']
      returns code: 200, desc: 'OK'
      error 401, 'Unauthorized'
      param :id, Integer, required: true ,:desc => "id for import_details"
      description <<-EOS
        == Description
          Details for import
        EOS
      def create
        if import_detail = ImportDetail.find_by(uuid: params["id"])
          if import_detail.error.blank?
            render json: { id: import_detail.id, status: import_detail.status, error: import_detail.error }
          else
            render json: {id: import_detail.id, status: import_detail.status, errors: JSON.parse(import_detail.error) }
          end
        else
          render json: { message: "bad_request" },status: :bad_request
        end
      end
    end
  end
end
