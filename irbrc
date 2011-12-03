# ----------------------------------------
# load gems
# ----------------------------------------
%w{rubygems hirb pp ap irb/ext/save-history irb/completion}.each do |lib| 
  begin 
    require lib 
  rescue LoadError => err
    $stderr.puts "Couldn't load #{lib}: #{err}"
  end
end

# ----------------------------------------
#  Wirble - irb enhancements
# ----------------------------------------
begin
  # load wirble
  require 'wirble'
  wirble_opts = {
    :skip_prompt    => true,
  }
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

# ---------------------------------------
#  Local methods for an object
# ---------------------------------------
class Object
  # Return a list of methods defined locally for a particular object.  Useful
  # for seeing what it does whilst losing all the guff that's implemented
  # by its parents (eg Object).
  def local_methods(obj = self)
    begin
      (obj.instance_methods - obj.class.superclass.instance_methods).sort
    rescue NoMethodError => err
      (obj.methods - obj.class.superclass.methods).sort
    end
  end
end

# ---------------------------------------
#  Benchmark block run time
# ---------------------------------------
def benchmark
  # From http://blog.evanweaver.com/articles/2006/12/13/benchmark/
  # Call benchmark { } with any block and you get the wallclock runtime
  # as well as a percent change + or - from the last run
  cur = Time.now
  result = yield
  print "#{cur = Time.now - cur} seconds"
  puts " (#{(cur / $last_benchmark * 100).to_i - 100}% change)" rescue puts ""
  $last_benchmark = cur
  result
end

# Unix-like functions
# List current directory content, or a directory.
# You can give a symbol to be faster :)
def ls(arg = '*')
  arg = arg.to_s if arg.is_a? Symbol
  if File.directory? arg
    Dir.chdir arg do
      Dir['*']
    end
  else
    Dir[arg]
  end
end

# Change directory to home, or directory given.
# Like ls function, give a symbol to be faster ;)
def cd(arg = nil)
  if arg.nil?
    Dir.chdir
  else
    arg = arg.to_s if arg.is_a? Symbol
    Dir.chdir arg
  end
  Dir.pwd
end

# Where am I?
def pwd
  Dir.pwd
end

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:PROMPT_MODE]  = :DEFAULT

def ri arg
  puts `ri -Tf ansi #{arg}`
end

class Module 
  def ri(meth=nil) 
    if meth 
      if instance_methods(false).include? meth.to_s 
    puts `ri -Tf ansi #{self}##{meth}` 
      end 
    else 
      puts `ri #{self}` 
    end 
  end 
end
