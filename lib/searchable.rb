class NoSearchableAttributes < StandardError; end;
module Searchable
  
  def self.included(base)
    raise NoSearchableAttributes unless base.column_names.any? do |column|
      !column.ends_with?('_id') && !%w(id created_at updated_at).include?(column)
    end
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def search(query)
      like = "%#{query}%"
      
      searchable_columns = column_names.select do |column|
        !column.ends_with?('_id') && !%w(id created_at updated_at).include?(column)
      end
      
      first_part = searchable_columns.collect{|column| "#{column} LIKE ?"}.join(" OR ")
      conditions = searchable_columns.inject([first_part]){|result,e| result << like}
      
      all(:conditions => conditions)
    end
  end
end