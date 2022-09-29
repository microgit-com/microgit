class Label < BaseModel
  table do
    column name : String
    column color : String
    belongs_to repository : Repository
    has_many label_in_items : LabelInItem
    has_many issues : Issue, through: [:label_in_items, :issue]
    has_many merge_requests : MergeRequest, through: [:label_in_items, :merge_request]
  end
end
