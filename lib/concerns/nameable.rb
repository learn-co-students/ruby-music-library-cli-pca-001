module Concerns
  module Nameable
    def create(name)
      new(name).tap(&:save)
    end
  end
end
