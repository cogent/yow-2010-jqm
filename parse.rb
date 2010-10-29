#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'json'
require 'yaml'

ROOT = "http://yowaustralia.com.au/melbourne/events_tracks/"

day = []
program = []

def day_specifier(string)
	string == "Day 1" || string == "Day 2"
end

class Events
	def initialize
		@events = JSON.load(File.open "34.js")
	end

	def getSpeakers(ids)
		speakerList = @events["speakerList"].select { |speaker| ids.include?(speaker["id"]) }
		speakers = {}
		speakerList.each do |speaker|
			speakers[speaker['id']] = speaker
		end
		speakers

	end

	def getSession(id)
		@events["eventList"].select { |event| event["id"] == id }.first
	end
end

e = Events.new

wanted_speaker_ids = []

doc = Nokogiri::HTML(File.open("index_tracks.html"))
doc.xpath("//table//table//table/tr").each do |tr|
	if day_specifier(tr.text.strip)
		program << day unless day.empty?
		day = []
		next
	end
	time = tr.xpath("td[@bgcolor='#dddddd']").text
	print "!!!!!!!!!!!!!!!!!! time = #{time}\n"
	sessions = []
	tr.xpath("td[position()>1]").each do |cell|
		track = cell.children.first
		title = cell.xpath(".//a")
		speaker = cell.xpath(".//strong")
		link = ROOT + cell.xpath(".//a/@href").to_s
		event_id = link.split("=").last
		session = e.getSession(event_id.to_i)
		speaker_ids = session && session['speakerIds'] ? session['speakerIds'] : []
		wanted_speaker_ids += speaker_ids
		sessions << { :id => event_id, 
						      :track => track.text.strip,
									:title => title ? title.text.strip : nil, 
									:speakers => speaker ? speaker.text.strip : nil, 
									:link => link, 
									:abstract => session ? session['aabstract'] : nil, 
									:speaker_ids => speaker_ids }
	end
	day << { :time => time, :sessions => sessions }
end

program << day unless day.empty?

document = { :days => program, :speakers => e.getSpeakers(wanted_speaker_ids) }

File.open("yow.json", "w") do |f|
	f.print document.to_json
end
File.open("yow.yaml", "w") do |f|
	f.print document.to_yaml
end
