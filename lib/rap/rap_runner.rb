require 'optparse'

module Rap
  class RapRunner

    def initialize(options={})
    end

    def run(args)
      options = {}

      optparse = OptionParser.new do |opts|
        opts.on( '-h', '--help', 'Display this screen' ) do
          puts opts
          exit
        end
      end

      optparse.parse!(args)

      do_configuration args
      cmd = @command_manager_class.instance

      cmd.command_names.each do |command_name|
        config_args = Gem.configuration[command_name]
        config_args = case config_args
                      when String
                        config_args.split ' '
                      else
                        Array(config_args)
                      end
        Gem::Command.add_specific_extra_args command_name, config_args
      end

      cmd.run Gem.configuration.args
      end_time = Time.now

      if Gem.configuration.benchmark then
        printf "\nExecution time: %0.2f seconds.\n", end_time - start_time
        puts "Press Enter to finish"
        STDIN.gets
      end
    end

    private

    def do_configuration(args)
      Gem.configuration = @config_file_class.new(args)
      Gem.use_paths(Gem.configuration[:gemhome], Gem.configuration[:gempath])
      Gem::Command.extra_args = Gem.configuration[:gem]
      @doc_manager_class.configured_args = Gem.configuration[:rdoc]
    end

  end
end