require 'rufus-scheduler'
require "net/http"
require "uri"
require 'rake'

Kaffeine::Application.load_tasks

def ping_last
	Rake::Task['scheduler:ping_last'].reenable
	Rake::Task['scheduler:ping_last'].invoke
end

def ping_all
	Rake::Task['scheduler:ping_all'].reenable
	Rake::Task['scheduler:ping_all'].invoke
end

ping_all
s = Rufus::Scheduler.new
s.every '30m' do
	ping_all
end