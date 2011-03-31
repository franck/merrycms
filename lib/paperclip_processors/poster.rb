require 'rvideo'
require 'logger'

module Paperclip
  class Poster < Processor

    attr_accessor :time_offset, :geometry, :whiny

    def initialize(file, options = {}, attachment = nil)
      super
      @time_offset = options[:time_offset] || '-4'
      @instance = attachment.instance
            
      @video = RVideo::Inspector.new(:file => file.path)
      @instance.width = @video.width
      @instance.height = @video.height
      
      @whiny = options[:whiny].nil? ? true : options[:whiny]
      @basename = File.basename(file.path, File.extname(file.path))
    end

    def make
      dst = Tempfile.new([ @basename, 'jpg' ].compact.join("."))
      dst.binmode

      cmd = %Q[-itsoffset #{time_offset} -i "#{File.expand_path(file.path)}" -y -vcodec mjpeg -vframes 1 -an -f rawvideo ]
      cmd << "-s #{@video.resolution} " if @video && @video.resolution
      cmd << %Q["#{File.expand_path(dst.path)}"]

      begin
        success = Paperclip.run('ffmpeg', cmd)
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error processing the thumbnail for #{@basename}" if whiny
      end
      dst
    end
  end
end