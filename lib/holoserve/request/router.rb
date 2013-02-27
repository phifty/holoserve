
class Holoserve::Request::Router

  def initialize(routes)
    @routes = routes
    substitute_paths
  end

  def dispatch(environment)
    route = find_route environment["REQUEST_METHOD"].downcase.to_sym,
                       environment["PATH_INFO"]

    if route
      if @parameters
        environment["parameters"] ||= { }
        environment["parameters"].merge! @parameters
      end
      route[:handler].response environment
    else
      nil
    end
  end

  private

  def substitute_paths
    @routes.each do |route|
      path = route[:path]
      if path.is_a?(String) && path =~ /:\w+/
        pattern = path.gsub(/:\w+/) do |match|
          name = match[1..-1]
          "(?<#{name}>.+)"
        end
        route[:path] = Regexp.new(pattern)
      end
    end
  end

  def find_route(method, path)
    @routes.detect do |route|
      (route.has_key?(:method) ? route[:method] == method : true) &&
        (route[:path].is_a?(Regexp) ? begin
        match = route[:path].match path
        if match
          @parameters = match.names.inject({ }) do |result, name|
            result[name.to_sym] = match[name]
            result
          end
          true
        else
          false
        end
      end : route[:path] == path)
    end
  end

end