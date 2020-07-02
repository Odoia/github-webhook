module Api
  module V1
    class PayloadController < ApplicationController

      def create
        if params[:issue].nil?
          render nothing: true, status: 400, json: { status: 400, data: 'Bad Request' }
        else
          result = format_github_issue_event
          render status: 201, json: { data: result, status: 201 }
        end
      end

      private

      def format_github_issue_event
        ::Services::Payloads::Create.new(all_params: params).call
      end
    end
  end
end
