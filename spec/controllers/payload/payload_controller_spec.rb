require 'rails_helper'

describe ::Api::V1::PayloadController, type: :controller do

  before do
    execute_actions
  end

  let(:json_status_open_with_comments) do
    path  = File.expand_path("payload_open_with_comment.json", 'spec/helpers/')
    file  = File.read(path)
    JSON.parse(file)
  end

  let(:json_status_open_without_comments) do
    path  = File.expand_path("payload_open_without_comment.json", 'spec/helpers/')
    file  = File.read(path)
    JSON.parse(file)
  end

  let(:json_status_closed_without_comments) do
    path  = File.expand_path("payload_closed_without_comment.json", 'spec/helpers/')
    file  = File.read(path)
    JSON.parse(file)
  end

  let(:json_status_closed_with_comments) do
    path  = File.expand_path("payload_closed_with_comment.json", 'spec/helpers/')
    file  = File.read(path)
    JSON.parse(file)
  end

  let(:execute_actions) {}

  context 'When need register a github payload' do
    context'When use payload with status open with comments' do
      let(:execute_actions) do
        post :create, params: json_status_open_with_comments
      end

      context 'when create a new issue' do
        it 'http status must be 201' do
          expect(response.status).to eq 201
        end

        it 'count must return 1' do
          expect(Issue.count).to eq 1
        end

        it "'issue title' must be title" do
          expect(Issue.first.title).to eq 'issue title'
        end

        it "'issue body' must be description" do
          expect(Issue.first.description).to eq 'issue body'
        end

        it "'Rspec' must be owner" do
          expect(Issue.first.owner).to eq 'Rspec'
        end

        it "'646919119' must be issue_id" do
          expect(Issue.first.issue_id).to eq 646919119
        end
      end

      context 'when create a new status' do
        it 'count must return 1' do
          expect(Status.count).to eq 1
        end

        it "'open' must be status title" do
          expect(Status.first.title).to eq 'open'
        end

        it "issue_id must be equal a last issue.id" do
          expect(Status.first.issue_id).to eq ::Issue.last.id
        end
      end

      context 'when create a new comment' do
        it 'count must return 1' do
          expect(Comment.count).to eq 1
        end

        it "'rspec comment' must be title" do
          expect(Comment.first.title).to eq 'rspec comment'
        end

        it "'Rspec' must be owner" do
          expect(Comment.first.sender).to eq 'Rspec'
        end

        it "issue_id must be equal a last issue.id" do
          expect(Comment.first.issue_id).to eq ::Issue.last.id
        end
      end
    end

    context'When use payload with status open without comments' do
      let(:execute_actions) do
        post :create, params: json_status_open_without_comments
      end

      context 'when create a new issue' do
        it 'count must return 1' do
          expect(Issue.count).to eq 1
        end
      end

      context 'when create a new status' do
        it 'count must return 1' do
          expect(Status.count).to eq 1
        end
      end

      context 'when not create a comment' do
        it 'count must return 0' do
          expect(Comment.count).to eq 0
        end
      end
    end

    context'When use payload with status closed without comments' do
      let(:execute_actions) do
        post :create, params: json_status_closed_without_comments
      end

      context 'when create a new issue' do
        it 'count must return 1' do
          expect(Issue.count).to eq 1
        end
      end

      context 'when create a new closed status' do
        it 'count must return 1' do
          expect(Status.count).to eq 1
        end

        it "'closed' must be status title" do
          expect(Status.first.title).to eq 'closed'
        end
      end

      context 'when not create comment' do
        it 'count must return 0' do
          expect(Comment.count).to eq 0
        end
      end
    end

    context'When use payload with status closed with comments' do
      let(:execute_actions) do
        post :create, params: json_status_closed_with_comments
      end

      context 'when create a new issue' do
        it 'count must return 1' do
          expect(Issue.count).to eq 1
        end
      end

      context 'when create a new status' do
        it 'count must return 1' do
          expect(Status.count).to eq 1
        end

        it "'closed' must be status title" do
          expect(Status.first.title).to eq 'closed'
        end
      end

      context 'when create a new comment' do
        it 'count must return 1' do
          expect(Comment.count).to eq 1
        end
      end
    end

    context'When use payload with status open and closed without comments' do
      let(:execute_actions) do
        post :create, params: json_status_open_without_comments
        post :create, params: json_status_closed_without_comments
      end

      context 'when create a new issue' do
        it 'count must return 1' do
          expect(Issue.count).to eq 1
        end
      end

      context 'when not create a comment' do
        it 'count must return 0' do
          expect(Comment.count).to eq 0
        end
      end

      context 'when create open status' do
        context 'when create closed status' do
          it 'count must return 2' do
            expect(Status.count).to eq 2
          end

          it 'open and closed must be cocontain on status title' do
            expect(Status.first.title).to eq 'open'
            expect(Status.second.title).to eq 'closed'
          end
        end
      end
    end
  end
end
