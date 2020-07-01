module Services
  module Payloads
    class Create

      def initialize(all_params:)
        @issue   = all_params[:issue]
        @comment = all_params[:comment]
        @status  = issue[:state]
        @sender  = all_params[:sender][:login]
      end

      def call
        make_payload
      end

      private

      attr_reader :issue, :comment, :status, :sender

      def make_payload
        ActiveRecord::Base.transaction do
          created_issue = create_issue
          create_status(created_issue)
          create_comment(created_issue) if comment
        end
      end

      def create_issue
        ::Services::Payloads::Issue::Create.new(issue: issue).call
      end

      def create_comment(created_issue)
        ::Services::Payloads::Comment::Create.new(comment: comment, issue_id: created_issue.id).call
      end

      def create_status(created_issue)
        ::Services::Payloads::Status::Create.new(status: status, sender: sender, issue: created_issue).call
      end
    end
  end
end
