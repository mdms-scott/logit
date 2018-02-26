require 'yaml'
class LogParser
  FULL_BODY_REGEX = /^\[(.*)\]\W(.*)$/
  START_LINE_REGEX = /^\[(.*)\].*(Started)\s(\S*)\s\"(\S*)\" for (.*) at (.*)$/
  PROCESSING_LINE_REGEX = /^\[(.*)\].*(Processing by)\s(\S*)\#(\S*) as (\S*)$/
  PARAMETER_LINE_REGEX = /^\[(.*)\].*(Parameters):\s*({.*})$/
  RENDER_LINE_REGEX = /^\[(.*)\].*(Rendered)\s(.*)\s\((.*)ms\)$/
  COMPLETED_LINE_REGEX = /^\[(.*)\].*(Completed)\s(\d*).*in\s(\d*)ms\s\(Views: (.*)ms\s\|\s.*: (.*)ms\)$/
  UNTAGGED_LINE_REGEX = /^([^\[].*)$/
  def self.parse_logs
    Dir.glob('log/parse_me/*.log') do |log_file|
      File.open(log_file, "r").each_line do |line|
        fbm = line.match(FULL_BODY_REGEX)
        sm = line.match(START_LINE_REGEX)
        pm = line.match(PROCESSING_LINE_REGEX)
        prm = line.match(PARAMETER_LINE_REGEX)
        rm = line.match(RENDER_LINE_REGEX)
        cm = line.match(COMPLETED_LINE_REGEX)
        um = line.match(UNTAGGED_LINE_REGEX)
        if fbm && fbm[1]
          request = Request.find_or_create_by(uuid: fbm[1])
          request.uuid = fbm[1]
          request.full_body.empty? ? request.full_body = fbm[2] : request.full_body << "\n#{fbm[2]}"
        elsif um
          request = Request.last # get the last request as we don't have a uuid here
          request.full_body << "\n#{um[1]}"
        end
        if sm && sm[2]
          request.request_type = sm[3]
          request.uri = sm[4]
          request.requester = sm[5]
          request.timestamp = sm[6]
        end
        if pm && pm[2]
          request.controller = pm[3]
          request.action = pm[4]
          request.request_type = pm[5]
        end
        if prm
          foo =  eval(prm[3].tr('"', "'"))
          request.parameters = foo
        end
        if rm && rm[2]
          request.render = rm[3]
          request.render_time = rm[4]
        end
        if cm && cm[2]
          request.response = cm[3]
          request.total_time = cm[4]
          request.view_time = cm[5]
          request.ar_time = cm[6]
        end

        request.save if request
      end
    end
  end
end
