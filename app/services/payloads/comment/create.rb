module Services
  module Payloads
    module Comment
      class Create

        def initialize(comment:, issue_id:)
          @comment  = comment[:body]
          @owner    = comment[:user][:login]
          @issue_id = issue_id
        end

        def call
          make_comment
        end

        private

        attr_reader :comment, :owner, :issue_id

        def make_comment
          comment = ::Comment.new(params_to_save)
          comment.save
          comment
        end

        def params_to_save
          {
            comment:  comment,
            owner:    owner,
            issue_id: issue_id
          }
        end
      end
    end
  end
end
