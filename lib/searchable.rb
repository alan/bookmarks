module Searchable
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def search(query)
      like = "%#{query}%"
      
      searchable_columns = column_names.select do |column|
        !column.ends_with?('_id') && !%w(id created_at updated_at).include?(column)
      end
      
      conditions = if searchable_columns.size == 0
                     raise ArgumentError, "There are no searchable fields in this model"
                   else
                     first_part = searchable_columns.collect{|column| "#{column} LIKE ?"}.join(" OR ")
                     searchable_columns.inject([first_part]){|result,e| result << like}
                   end
      
      all(:conditions => conditions)
    end
  end
end