module Rap
  class Config
    
    # ripped-off from rubygems
    system_config_path =
      begin
        require 'Win32API'

        CSIDL_COMMON_APPDATA = 0x0023
        path = 0.chr * 260
        SHGetFolderPath = Win32API.new 'shell32', 'SHGetFolderPath', 'PLPLP', 'L',
                                       :stdcall
        SHGetFolderPath.call nil, CSIDL_COMMON_APPDATA, nil, 1, path

        path.strip
      rescue LoadError
        '/etc'
      end

    SYSTEM_WIDE_CONFIG_FILE = File.join system_config_path, 'rubyraprc'
    
    def initialize
      
      @system_config  = load_file(SYSTEM_WIDE_CONFIG_FILE)
      @user_config    = load_file(File.join(find_home, '.rubyraprc'))
      
    end
    
    def find_home
      File.expand_path "~"
    rescue
      if File::ALT_SEPARATOR then
        "C:/"
      else
        "/"
      end
    end
    
    def load_file(filename)
      return {} unless filename and File.exists?(filename)
      begin
        require 'yaml'
        YAML.load(File.read(filename))
      rescue ArgumentError
        warn "Failed to load #{config_file_name}"
      rescue Errno::EACCES
        warn "Failed to load #{config_file_name} due to permissions problem."
      end or {}
    end
    
    
  end
end