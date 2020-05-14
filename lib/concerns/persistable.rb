module Concerns
  module Persistable
    module InstanceMethods
      def save
        self.class.all << self
        self
      end
    end

    module ClassMethods
      def self.extended(base)
        base.class_variable_set(:@@all, [])
      end

      def all
        class_variable_get(:@@all)
      end

      def count
        all.count
      end

      def destroy_all
        all.clear
      end
    end
  end
end
