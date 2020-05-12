class LabelInItem < BaseModel
  table do
    belongs_to label : Label
    belongs_to issue : Issue?
    belongs_to merge_request : MergeRequest?

    polymorphic item, associations: [:issue, :merge_request]
  end
end
