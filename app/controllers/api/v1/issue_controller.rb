module Api
  module V1
    class IssueController < ApplicationController

      def index
        result = all_issues
        unless result.nil?
          render status: 200, json: { data: result, status: 200 }
        else
          render nothing: true, status: 404, json: { status: 404, data: 'Not Found' }
        end
      end

      def show
        result = find_issue
        if result
          render status: 200, json: { data: result, status: 200 }
        else
          render nothing: true, status: 404, json: { status: 404, data: 'Not Found' }
        end
      end

      private

      def all_issues
        ::Services::Payloads::Issue::Index.new().call
      end

      def find_issue
        ::Services::Payloads::Issue::Show.new(issue_id: params[:id]).call
      end
    end
  end
end
