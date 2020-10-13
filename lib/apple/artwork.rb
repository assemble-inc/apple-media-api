module Apple
  class Artwork
    attr_reader :width, :height, :text_colors, :bg_color, :attributes

    def initialize(attrs = {}, parent = nil)
      @parent = parent

      @supports_layered_image = attrs[:supportsLayeredImage]
      @text_colors = [
        attrs[:textColor1],
        attrs[:textColor2],
        attrs[:textColor3],
        attrs[:textColor4]
      ]
      @bg_color = attrs[:bgColor]
      @no_dimensions = attrs[:width].nil? && attrs[:height].nil?
      @width = attrs[:width].nil? ? 1 : attrs[:width].to_i
      @height = attrs[:height].nil? ? 1 : attrs[:height].to_i
      @url = attrs[:url]
      @attributes = attrs
    end

    def raw_url
      @url
    end

    def url(width: nil, height: nil, format: nil, cropping: nil)
      match = url.match(/(?<width>{w})x(?<height>{h})(?:\.|(?<cropping>.*?)\.)(?<format>[\w{}]+)(?<s>\?|$)(?<query>.+$|$)/)

      # cut off the end of the url to be replaced with the final data
      res = url.gsub(/\{w\}.+$/ , '')

      format ||= (match[:format] == '{f}') ? 'jpeg' : match[:format]
      cropping ||= (match[:cropping] == '{c}') ? 'bb' : match[:cropping]

      new_width, new_height = self.adjust_sizes(width: width, height: height, cropping: cropping)

      "#{res}#{new_width}x#{new_height}#{cropping}.#{format}#{match[:s]}#{match[:query]}"
    end

    def adjust_sizes(width: nil, height: nil)
      if !width.blank? && !height.blank?
        [width, height]
      else
        # if you send only one demension scale the other one to the right ratio
        width = 200 if width.nil? && height.nil?
        width = (@width / (@height / height.to_f)) if width.nil? && !height.nil?
        height = (@height / (@width / width.to_f)) if height.nil?

        new_width = width
        new_height = height

        unless @no_dimensions
          modifier = [(@width / width.to_f), (@height / height.to_f)].max
          new_width = (@width / modifier).round
          new_height = (@height / modifier).round
        end

        [new_width.to_i, new_height.to_i]
      end
    end
  end
end
