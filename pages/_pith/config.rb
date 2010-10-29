project.assume_content_negotiation = true
project.assume_directory_index = true

project.helpers do
  
  def yow_yaml
    @yow_yaml ||= File.expand_path("../../../yow.yaml", __FILE__)
  end

  def yow_days
    YAML.load(File.open(yow_yaml))[:days]
  end

end
