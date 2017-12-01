
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "postmark_mailer/version"

Gem::Specification.new do |spec|
  spec.name          = "postmark_mailer"
  spec.version       = PostmarkMailer::VERSION
  spec.authors       = ["John Ellis"]
  spec.email         = ["john@scienceexchange.com"]

  spec.summary       = %q{An ActionMailer replacement for those wishing to send emails using Postmark Templates.}
  spec.description   = %q{Designed to mimic ActionMailer's familiar interface, this gem offers a way to send transactional emails that are rendered by Postmark's Templates feature and delivered via the Postmark API.}
  spec.homepage      = "https://github.com/scienceexchange/postmark_mailer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "activejob", "~> 4.2"
  spec.add_dependency "postmark"
end
