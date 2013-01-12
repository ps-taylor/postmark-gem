module Postmark
  module SharedMessageExtensions

    def tag
      self['TAG']
    end

    def tag=(value)
      self['TAG'] = value
    end

    def postmark_attachments=(value)
      @_attachments = Array[*value]
    end

    def postmark_attachments
      return if @_attachments.nil?

      @_attachments.map do |item|
        if item.is_a?(Hash)
          item
        elsif item.is_a?(File)
          {
            "Name"        => item.path.split("/")[-1],
            "Content"     => [ IO.read(item.path) ].pack("m"),
            "ContentType" => "application/octet-stream"
          }
        end
      end
    end

  end
end
