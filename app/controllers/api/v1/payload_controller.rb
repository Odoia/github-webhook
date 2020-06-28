module Api
  module V1
    class PayloadController < ApplicationController

      def github_event
        if params[:issue].nil?
          render nothing: true, status: 404, json: { status: 404, data: 'Not Fount' }
        else
          result = format_github_issue_event
          render json: { data: result, status: 201 }
        end
      end

      private

      def format_github_issue_event
        ::Services::Payloads::Create.new(all_params: params).call
      end
    end
  end
end
