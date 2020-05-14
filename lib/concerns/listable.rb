module Concerns
  module Listable
    # Listable class should have .all class method available

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
        num = "#{i + 1}. "
        strs = attrs.map { |attr| item.send(attr).to_s }
        puts num + strs.join(" - ")
      end
      true
    end
  end
end
