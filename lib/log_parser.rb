class LogParser
  def self.parse_logs
    Dir.glob('log/parse_me/*.log') do |log_file|
      File.open(log_file, "r").each_line do |line|
        puts line
      end
    end
  end
end
