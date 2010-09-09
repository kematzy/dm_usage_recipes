
APP_ROOT = File.expand_path(File.dirname(__FILE__))

begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('/.bundle/environment', __FILE__)
rescue LoadError => e
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

##  DEFAULT REQUIREMENTS

# SQLITE3 Adapter used by default
Bundler.require(:default, :dm_sqlite_adapter)
# Bundler.require(:default, :dm_mysql_adapter)


## HELPER METHODS

def load_models(*models)
  models.each do |model|
    require "#{APP_ROOT}/shared/models/#{model}"
  end
end

def load_shared_specs_for(*specs)
  specs.each do |spec|
    require "#{APP_ROOT}/shared/specs/#{spec}_shared"
  end
end


