require 'rspec/core'
require 'fileutils'
require 'pathname'

$:.unshift( File.expand_path('..', __FILE__) )
$:.unshift( File.expand_path('../../lib', __FILE__) )

require 'rap/vendor/zip/zipfilesystem'

module SH
  def fixtures_path(path='')
    Pathname.new( File.expand_path('../fixtures', __FILE__) ).join(path)
  end

  def projects_path(path='')
    Pathname.new( File.expand_path('../projects', __FILE__) ).join(path)
  end

  def artifacts_path(path='')
    Pathname.new( File.expand_path('../artifacts', __FILE__) ).join(path)
  end

  def tmp_path(path='')
    Pathname.new( File.expand_path('../tmp', __FILE__) ).join(path)
  end
end

RSpec.configure do |c|
  c.around(:all, :fixtures => true) do |example|
    FileUtils.rm_rf( tmp_path ) if ::File.exists?( tmp_path )
    FileUtils.cp_r( fixtures_path, tmp_path )

    Zip::ZipFile.open(fixtu"my.zip", Zip::ZipFile::CREATE) do |zip|
     zipfile.file.open("first.txt", "w") { |f| f.puts "Hello world" }
     zipfile.dir.mkdir("mydir")
     zipfile.file.open("mydir/second.txt", "w") { |f| f.puts "Hello again" }
    }

    example.run
  
    FileUtils.rm_rf( tmp_path ) if ::File.exists?( tmp_path )
  end
end

include SH