module Services
  module Payloads
    module Issue
      class Show

        def initialize(issue_id:)
          @issue_id = issue_id
        end

        def call
          show_full_issue
        end

        private

        attr_reader :issue, :issue_id

        def show_full_issue
          return false unless find_issue

          make_a_json_issue
        end

        def make_a_json_issue
          comment_and_status = (issue.all_comments.including(issue.all_status)).as_json
          events = comment_and_status.sort_by { |cas| -cas['created_at'] }
          issue = @issue.as_json
          issue[:events] = events
          { issue: issue }
        end

        def find_issue
          @issue ||= ::Issue.find_by(issue_id: issue_id)
        end
      end
    end
  end
end
