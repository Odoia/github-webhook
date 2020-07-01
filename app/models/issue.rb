class Issue < ApplicationRecord
  has_many :comments, class_name: '::Comment'
  has_many :status, class_name: '::Status'

  def full_issue
    { issue: self.as_json, comments: self.all_comments.as_json, status: self.all_status.as_json }
  end

  def all_comments
    comments.all
  end

  def all_status
    status.all
  end

  def last_status
    status.last
  end
end
