module Concerns
  module Listable
    def list_all_alpha_by_name
      list_alpha_by_name(all)
    end

    def list_alpha_by_name(listable_collection)
      listable_collection.sort_by(&:name).each_with_index do |item, i|
        puts "#{i+1}. #{item}"
      end
    end

    def list_by_attributes(collection, *attrs)
      collection = collection.sort_by(&:name)
      collection.each_with_index do |item, i|
        str = "#{i + 1}. "

        attrs.each do |attr|
          str += "#{item.send(attrs[0])}"
          str += " - " unless attr = attrs[attrs.size]
        end
      end

    end

  end
end
