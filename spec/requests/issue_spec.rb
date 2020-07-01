require 'rails_helper'

describe '::Api::V1::IssueController', type: :request do

  before do
    execute_actions
  end

  let(:execute_actions) {}

  let(:user) { FactoryBot.create(:user) }

  let(:token) { AuthenticateUser.call(user.email, user.password) }

  let(:json_status_open_with_comments) do
    path  = File.expand_path("payload_open_with_comment.json", 'spec/helpers/')
    file  = File.read(path)
    JSON.parse(file)
  end

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

  let(:make_comment) do
    ::Comment.new({
      title:  'comment title',
      event_type:  'comment',
      sender:    'owner',
      issue_id: ::Issue.first.id
    }).save
  end

  let(:make_10_comments) do
    x = 0
    while x < 10 do
      ::Comment.new({
        title:  'comment title',
        event_type:  'comment',
        sender:    'owner',
        issue_id: ::Issue.first.id
      }).save
      x += 1
    end
  end

  let(:make_status) do
    ::Status.new({
      title:  'open',
      event_type:  'status',
      sender:    'owner',
      issue_id: ::Issue.first.id
    }).save
  end

  let(:make_10_status) do
    x = 0
    while x < 10 do
      ::Status.new({
        title:  'open',
        event_type:  'status',
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
        make_10_comments
        make_status
        get '/api/v1/issue', params: {}, headers: { 'ACCEPT' => 'application/json', :Authorization => "bearer #{token.result}" }
      end

      it 'http status must be 200' do
        expect(response.status).to eq 200
      end

      it "first title of issue must be 'title_0'" do
        body = JSON.parse response.body
        expect(body['data'].first['issue']['title']).to eq('title_0')
      end

      it "first data must be 'issue' and 'events'" do
        body = JSON.parse response.body
        expect(body['data'].first).to include('issue')
        expect(body['data'].first['issue']).to include('events')
      end

      it 'count must return 10' do
        body = JSON.parse response.body
        expect(body['data'].count).to eq 10
      end

      context 'When issue has a one comment' do
        let(:execute_actions) do
          make_10_issues
          make_status
          make_comment
          get "/api/v1/issue/#{::Issue.first.issue_id}", params: { }, headers: { 'ACCEPT' => 'application/json', :Authorization => "bearer #{token.result}" }
        end

        it 'http status must be 200' do
          expect(response.status).to eq 200
        end

        it 'count must return 1'do 
          body = JSON.parse response.body
          expect(body['data'].count).to eq 1
        end

        it 'first event_type must be status'do 
          body = JSON.parse response.body
          expect(body['data']['issue']['events'].first['event_type']).to eq 'status'
        end

        it 'second event_type must be comment'do 
          body = JSON.parse response.body
          expect(body['data']['issue']['events'].second['event_type']).to eq 'comment'
        end
      end
    end
  end
end
