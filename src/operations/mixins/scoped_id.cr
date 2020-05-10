module AvramScopeId
  extend self

  def set(column : Avram::Attribute(Int32?),
        query : Avram::Queryable) : Nil
    set(column, query)
  end

  def set(column : Avram::Attribute(Int32?),
          query : Avram::Queryable) : Nil
    id = get_next_scoped_id(query, column)
    column.value = id.to_i
  end

  private def get_next_scoped_id(query, column)
    scope = query.scoped_id.select_max
    current_max_scoped_id = scope || 0
    current_max_scoped_id + 1
  end
end
