module ProcessConnection
  class SiblingList
    def initialize(master_port, worker_port, &block)
      @block = block
      Thread.new { run master_port, worker_port }
    end

    def run(master_port, worker_port)
      socket = TCPSocket.new('localhost', master_port)
      socket.puts worker_port
      loop do
        ports = socket.gets.scan(/\d+/).map(&:to_i)
        @block.call ports
      end
    ensure
      exit
    end
  end
end