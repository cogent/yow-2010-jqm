require "rubygems"
gem "bundler", ">= 1.0.0"

require "bundler"
Bundler.setup(:default)

task "default" => "watch"

desc "build the site"
task "build" do
  sh("pith -i pages build")
end

desc "build the site, and rebuild incrementally when stuff changes"
task "watch" do
  sh("pith -i pages watch")
end

desc "serve the site at http://localhost:4321, whilst rebuilding incrementally"
task "serve" do
  sh("pith -i pages serve")
end
