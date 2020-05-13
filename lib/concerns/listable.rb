module Concerns
  module Listable
    # Listable class should have @@all class var available

    def list_all_alpha_by_name
      list_alpha_by_name(all)
    end

    def list_alpha_by_name(items)
      list_by_attributes(items, :name)
    end

    def sort_alpha_by_name(collection)
      collection.sort_by(&:name)
    end

    def list_all_by_attributes(*attrs)
      list_by_attributes(all, *attrs)
    end

    def list_by_attributes(collection, *attrs)
      sort_alpha_by_name(collection).each_with_index do |item, i|
        str = "#{i + 1}. "

        attrs.each do |attr|
          str += "#{item.send(attr)}"
          str += " - " unless attr == attrs.last
        end
        puts str
      end
      true
    end

  end
end
