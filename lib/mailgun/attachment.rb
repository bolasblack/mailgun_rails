module Mailgun
  class Attachment < StringIO
    attr_reader :original_filename, :content_type, :path

    def initialize (attachment, *rest)
      @path = ''
      if rest.detect {|opt| opt[:inline] }
        basename = @original_filename = attachment.cid
      else
        basename = @original_filename = attachment.filename
      end
      @content_type = attachment.content_type.split(';')[0]
      super basename, *rest
      binmode
      write attachment.body.decoded
      rewind
    end
  end
end
