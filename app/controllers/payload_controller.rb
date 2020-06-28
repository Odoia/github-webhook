class PayloadController < ApplicationController

  def github_event
    format_github_issue_event
    render json: { status: 201 }
  end

  private

  def format_github_issue_event
    ::Services::Payloads::Create.new(all_params: params).call
  end
end
