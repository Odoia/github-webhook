module Services
  module Payloads
    class Create

      def initialize(all_params:)
        @issue   = all_params[:issue]
        @comment = all_params[:comment]
        @status  = issue[:state]
      end

      def call
        make_payload
      end

      private

      attr_reader :issue, :comment, :status

      def make_payload
        ActiveRecord::Base.transaction do
          create_issue
          create_comment if comment
          create_status
        end
      end

      def create_issue
        @issue = ::Services::Payloads::Issue::Create.new(issue: issue).call
      end

      def create_comment
        @comment = ::Services::Payloads::Comment::Create.new(comment: comment, issue_id: issue.issue_id).call
      end

      def create_status
        @status = ::Services::Payloads::Status::Create.new(status: status, issue_id: issue.issue_id).call
      end
    end
  end
end
