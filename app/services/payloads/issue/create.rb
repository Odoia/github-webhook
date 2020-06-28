module Services
  module Payloads
    module Issue
      class Create

        def initialize(issue:)
          @issue_id    = issue[:id]
          @title       = issue[:title]
          @description = issue[:body]
          @owner       = issue[:user][:login]
        end

        def call
          make_issue
        end

        private

        attr_reader :issue_id, :title, :description, :owner, :issue

        def make_issue
          return issue if find_issue

          issue = ::Issue.new(params_to_save)
          issue.save
          issue
        end

        def params_to_save
          {
            issue_id:    issue_id,
            title:       title,
            description: description,
            owner:       owner
          }
        end

        def find_issue
          @issue ||= ::Issue.find_by(issue_id: issue_id)
        end
      end
    end
  end
end
