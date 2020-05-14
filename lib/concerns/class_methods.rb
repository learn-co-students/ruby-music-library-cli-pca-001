module Concerns
  module InstanceMethods
    def save
      self.class.all << self
    end
  end

  module ClassMethods
    def destroy_all
      self.all.clear
    end

    def create(name)
      instance = new(name)
      instance.save
      instance
    end
  end
end
