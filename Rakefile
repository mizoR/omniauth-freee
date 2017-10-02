#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require "bundler/gem_helper"

RSpec::Core::RakeTask.new

desc 'Run specs'
task :default => :spec

t = Bundler::GemHelper.new

desc "Create tag #{  t.send(:version_tag)}"
task :tag do
  t.send(:tag_version) { t.send(:git_push) } unless t.send(:already_tagged?)
end
