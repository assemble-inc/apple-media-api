require 'apple/music/base'

module Apple
  module Music
    class Station < Apple::Music::Base
      object_attr_reader :Artwork, :artwork

      def url
        attributes[:url]
      end

      def name
        attributes[:name]
      end

      def description
        attributes[:editorialNotes] ? (attributes[:editorialNotes][:standard] || attributes[:editorialNotes][:short]) : ""
      end

      def description_short
        attributes[:editorialNotes] ? (attributes[:editorialNotes][:short] || "") : ""
      end
    end
  end
end
