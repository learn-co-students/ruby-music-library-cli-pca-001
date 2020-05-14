module Concerns
  module Nameable
    def create(name)
      new(name).save
    end
  end
end
