module Services
  module Payloads
    module Issue
      class Index

        def call
          full_issue_json
        end

        private

        attr_reader :issues

        def full_issue_json
          return [] unless all_issues

          make_a_json_issue
        end

        def make_a_json_issue
          issues.map do |issue|
            comment_and_status = (issue.all_comments.including(issue.all_status)).as_json
            events = comment_and_status.sort_by { |cas| -cas['created_at'] }
            issue = issue.as_json
            issue[:events] = events
            { issue: issue }
          end
        end

        def all_issues
          @issues ||= ::Issue.all
        end
      end
    end
  end
end
