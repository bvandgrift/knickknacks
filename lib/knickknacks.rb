module Knickknacks
  ##
  # occludes all parts of a url (except protocol) from 
  def sanitize_url(url, exclusions=[])
    exclusions = exclusions.map(&:to_s)
    return unless url
    return url if exclusions.empty?

    path, query_string = url.split('?')
    path = path.split('/').map { |part| exclusions.include?(part) ? '***' : part }.join('/')

    if query_string
      path << '?' << sanitize_query_string(query_string, exclusions)
    end
    path
  end

  def sanitize_query_string(query_string, exclusions=[])
    query_string.split('&').map do |pair|
      k, v = pair.split('=')
      [(exclusions.include?(k) ? '***' : k), (exclusions.include?(v) ? '***' : v)].join('=')
    end.join('&')
  end
end
