require 'unicorn'

class Application::Runner

  def run
    base_directory = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))
    system "cd #{base_directory} && bundle exec unicorn"
  end

end
