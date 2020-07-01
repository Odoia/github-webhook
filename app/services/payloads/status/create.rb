module Services
  module Payloads
    module Status
      class Create

        def initialize(status:, issue:, sender:)
          @status   = status
          @sender   = sender
          @issue    = issue
        end

        def call
          make_status
        end

        private

        attr_reader :status, :issue, :sender, :state

        def make_status
          return state if find_status

          status = ::Status.new(params_to_save)
          status.save
          status
        end

        def params_to_save
          {
            title:      status,
            event_type: 'status',
            sender:     sender,
            issue_id:   issue.id
          }
        end

        def find_status
          @state ||= ::Status.find_by(title: status, issue_id: issue.id, sender: sender) if issue.last_status&.title == status
        end
      end
    end
  end
end
