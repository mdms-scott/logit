class LogParser
  def self.parse_logs
    Dir.glob('log/parse_me/*.log') do |log_file|
      File.open(log_file, "r").each_line do |line|
        foo = line.match(/^\[(.*)\]\W(.*)$/)
        if foo && foo[1]
          puts foo[1]
          puts foo[2]
          # Request.where(uuid: foo[1]).first_or_create do |request|
          request = Request.find_or_create_by(uuid: foo[1])
          request.uuid = foo[1]
          request.full_body.empty? ? request.full_body = foo[2] : request.full_body << "\n#{foo[2]}"

          request.save
          # end
        end
        # puts line
        # puts foo[1]
      end
    end
  end
end
