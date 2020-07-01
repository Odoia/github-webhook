require 'rails_helper'

describe ::Api::V1::IssueController, type: :controller do

  before do
    execute_actions
  end

  let(:json_status_open_with_comments) do
    path  = File.expand_path("payload_open_with_comment.json", 'spec/helpers/')
    file  = File.read(path)
    JSON.parse(file)
  end

  let(:execute_actions) {}

  let(:make_10_issues) do
    x = 0
    while x < 10 do
      ::Issue.new({
        issue_id:    22,
        title:       "title_#{x}",
        description: 'description',
        owner:       'owner'
      }).save
      x += 1
    end
  end

  let(:make_commentt) do
    ::Comment.new({
      comment:  'comment',
      sender:    'owner',
      issue_id: 616
    }).save
  end

  let(:make_comment) do
    x = 0
    while x < 10 do
    ::Comment.new({
      comment:  'comment',
      sender:    'owner',
      issue_id: ::Issue.first.id
    }).save
    x += 1
    end
  end

  let(:make_status) do
    x = 0
    while x < 10 do
    ::Status.new({
      status:  'open',
      sender:    'owner',
      issue_id: ::Issue.first.id
    }).save
    x += 1
  end
  end

  context 'When given a 10 issues' do
    context 'When need show all registered issues' do

      let(:execute_actions) do
        make_10_issues
        make_comment
        make_commentt
        make_status
        get :index
      end

      it 'http status must be 200' do
        expect(response.status).to eq 200
      end

      it "first title of issue must be 'title_0'" do
        body = JSON.parse response.body
        expect(body['data'].first['title']).to eq('title_0')
      end

      it "first data must be 'issue' and 'comment'" do
        body = JSON.parse response.body
        expect(body['data'].first).to include('issue')
        expect(body['data'].first).to include('comment')
      end

      it 'count must return 10' do
        body = JSON.parse response.body
        expect(body['data'].count).to eq 10
      end

      context 'When issue has a one comment' do
        it 'count must return 1'do 
          expect(Comment.count).to eq 1
        end
      end

        xcontext 'When issue has one status' do
        it 'count must return 1' do
          expect(Status.count).to eq 1
        end
      end
    end
  end
end
