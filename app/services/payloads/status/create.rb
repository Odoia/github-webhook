module Services
  module Payloads
    module Status
      class Create

        def initialize(status:, issue_id:)
          @status  = status
          @issue_id = issue_id
        end

        def call
          make_status
        end

        private

        attr_reader :status, :issue_id, :state

        def make_status
          return state if find_status

          status = ::Status.new(params_to_save)
          status.save
          status
        end

        def params_to_save
          {
            status:   status,
            issue_id: issue_id
          }
        end

        def find_status
          @state ||= ::Status.find_by(status: status, issue_id: issue_id)
        end
      end
    end
  end
end
