require 'apple/base'

module Apple
  module Music
    class Base < Apple::Base
      def self.object_relation_reader(klass_sym, *keys)
        object_reader :relationships, Apple::Music::Relation.const_get(klass_sym), *keys
      end
    end
  end
end
