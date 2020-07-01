class Status < ApplicationRecord
   has_one :issue, class_name: '::Issue'
end
