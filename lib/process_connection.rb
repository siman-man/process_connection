require "socket"

require "process_connection/version"
require "process_connection/master"
require "process_connection/sibling_list"
require "process_connection/worker"

module ProcessConnection
  def self.start_master
    Master.start
  end

  def self.master_port
    Master.port
  end

  def self.start(master_port = ProcessConnection.master_port, &block)
    Worker.start master_port, &block
  end

  def self.broadcast(*args)
    Worker.instance.broadcast(*args)
  end
end