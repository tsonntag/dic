class DicError < StandardError; end
class Dic
  attr_reader :procs

  def initialize
    @procs = {}
    @values = {}
    @log_activity = false
    @stack = []
  end

  def respond_to_missing?(name,include_private)
    self[name] or super
  end

  def method_missing(name, *args, &proc)
    # setter
    if args.size == 1 || !proc.nil?
      name = name.to_s.gsub(/=$/,'').intern
      self[name]= args.first || proc
    # getter
    elsif args.empty? && proc.nil?
      self[name] or super 
      # raise DicError, "#{self.class}: undefined entry #{name}"
    else
      super
      #raise ArgumentError, "invalid argument #{name}, #{args.inspect}"
    end
  end

  def [](key)
    unless @values.has_key?(key)
      raise Dic::DicError, "recursively resolving key #{key}, stack=#{@stack.inspect}" if @stack.include?(key)
      @stack.push key
      @values[key] = create(key)
      debug{"resolved key=#{key}=#{@values[key].inspect}"}
      @stack.pop
    end
    @values[key]
  end

  def []=(name,proc)
    debug{"setting #{name}=#{proc.inspect}"}
    @procs[name] = proc
    @values.delete(name)
  end

  def create(key)
    if (proc = @procs[key])
      res = proc.respond_to?(:call) ? proc.call : proc
      debug{"created for key=#{key}=#{res.inspect}, proc=#{proc}"}
    else
      res = nil
      debug{"created for key=#{key} => nil"}
    end
    res
  end

  alias_method :set, :[]=

  def keys
    @procs.keys
  end

  def values
    keys.each{|key|self[key]}
    @values
  end

  def reset
    puts "#{self}: reset"
    @values.clear
  end

  def dump
    puts "dumping #{self}"
    puts "=========================="
    keys.sort{|a,b|a.to_s <=> b.to_s}.each do |key|
      value = begin
        self[key]
      rescue Exception => e
        "ERROR: #{e.inspect}"
      end
      puts "%-20s = %s" % [ key, value ]
    end
  end

  protected
  def debug(msg=nil)
    msg = msg || yield
    puts "#{self}: #{msg}" if $DEBUG 
  end
end
