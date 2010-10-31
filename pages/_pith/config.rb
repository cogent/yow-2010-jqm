project.assume_content_negotiation = true
project.assume_directory_index = true

project.helpers do
  
  def yow_yaml
    @yow_yaml ||= File.expand_path("../../../yow.yaml", __FILE__)
  end

  def yow_days
    YAML.load(File.open(yow_yaml))[:days]
  end

  def yow_sessions
    sessions = yow_days.map { |day| day.map { |timeslot| timeslot[:sessions] } }.flatten
    sessions.sort {|x,y| x[:title] <=> y[:title]}
  end

  def yow_speakers
    speakers = YAML.load(File.open(yow_yaml))[:speakers].values
    speakers.sort {|x,y| x['name'] <=> y['name']}
  end

end
