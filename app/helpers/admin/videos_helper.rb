module Admin
  module VideosHelper
    
    def display_video_size(video)
      main_source = video.sources.first
      number_to_human_size main_source.video_file_size if main_source
    end
    
    def display_video(video, width=nil, height=nil)
      return unless video
      
      main_source = video.sources.first
      if main_source.nil?
        html = "<p>#{t('videos.no_source')}</p>"
        return html
      end
      
      width = width ? width : main_source.width
      height = height ? height : main_source.height
      poster = main_source.video.url(:poster, false)
      flash_player = 'http://releases.flowplayer.org/swf/flowplayer-3.2.1.swf'
      video_alt = 'Poster image'
      poster_title = video.title
      
      sources = video.sources.map do |source|
        { :src => "http://localhost:3000#{source.video.url(:original, false)}", :type => "#{source.video_content_type}" }
      end
      
      html = ""
      
      html << "<div class='video-js-box vim-css'>"
      
      html << "<video id='example_video_1' class='video-js' width='#{width}' height='#{height}' controls='controls' preload='auto' poster='#{poster}'>"
      
      sources.each do |source|
        html << "<source src='#{source[:src]}' type='#{source[:type]}' />"
      end

      html << "<object id='flash_fallback_1' class='vjs-flash-fallback' width='#{width}' height='#{height}' type='application/x-shockwave-flash' data='#{flash_player}'>"
      html << "<param name='movie' value='#{flash_player}' />"
      html << "<param name='allowfullscreen' value='true' />"
      html << "<param name='flashvars' value='config={\"playlist\":[\"#{poster}\", {\"url\":\"#{sources[0][:src]}\",\"autoPlay\":false,\"autoBuffering\":true}]}' />"
            
      html << "<img src='#{poster}' width='#{width}' height='#{height}' alt='#{video_alt}' title='#{poster_title}' />"       
      html << "</object>"
      html << "</video>"
      html << "</div>"
      
      html
    end
    
  end
end