
require 'rubygems'
require 'rake'

require 'spec/rake/spectask'

namespace :spec do
  
  # TODO:: Make the combined specs work. Now fails with:
  #   dm-core-1.0.2/lib/dm-core/model/relationship.rb:373:in `method_missing': 
  #   undefined method `auto_generate_validations' for Post:Class (NoMethodError)
  #
  # All the individual tests passes
  
  # desc "Run the specs for all gems"
  # Spec::Rake::SpecTask.new(:all) do |spec|
  #   spec.libs << 'gems' << 'shared'
  #   spec.spec_opts = ["--color", "--format", "nested"]
  #   # spec.spec_files = FileList['gems/**/*.rb']
  #   spec.spec_files = FileList['gems/**/*.rb']
  # end
  
  
  desc "Run the specs for a single gem ( G=dm-gemname)"
  Spec::Rake::SpecTask.new(:gem) do |t|
    t.libs << 'gems' << 'shared'
    t.spec_files = FileList["gems/#{ENV["G"]}/**/*.rb"]
    t.spec_opts = ["--color", "--format", "nested", ] 
  end
  
end
