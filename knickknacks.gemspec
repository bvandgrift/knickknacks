Gem::Specification.new do |s|
  s.name = 'knickknacks'
  s.version = '0.0.0'
  s.date = '2010-06-10'
  s.summary = 'some knickknacks a rubyist might find useful'
  s.author = 'Ben Vandgrift'
  s.bindir = 'bin'
  s.files = [
    'lib/knickknacks.rb'
  ]
  s.require_paths = ['lib']
  s.add_development_dependency 'rspec', '~> 3.9.0'
end
