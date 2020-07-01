class Comment < ApplicationRecord
   has_one :issue, class_name: '::Issue'
end

