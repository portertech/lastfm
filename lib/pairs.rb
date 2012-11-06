require "thread"

DATA_FILE = File.join(File.dirname(__FILE__), "Artist_lists_small.txt")

class LastFMPairs
  def initialize
    @lines = Queue.new
    @permutations = Queue.new
    @pairs = Hash.new(0)
  end

  def read_data
    Thread.new do
      File.open(DATA_FILE, "r") do |file|
        file.each_line do |line|
          @lines << line
        end
      end
      @lines << "quit"
    end
  end

  def create_worker
    Thread.new do
      loop do
        line = @lines.shift
        if line == "quit"
          @lines << "quit"
          @permutations << "quit"
          break
        end
        line.split(",").permutation(2).each do |pair|
          @permutations << pair.join(",")
        end
      end
    end
  end

  def reduce
    loop do
      permutation = @permutations.shift
      break if permutation == "quit"
      @pairs[permutation] += 1
    end
  end

  def result
    @pairs.reject! {|key, count| count < 50 }
    puts @pairs.keys.join("\n")
  end

  class << self
    def run
      pairs = self.new
      pairs.read_data
      2.times do
        pairs.create_worker
      end
      pairs.reduce
      pairs.result
    end
  end
end
