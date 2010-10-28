project.assume_content_negotiation = true
project.assume_directory_index = true

project.helpers do
  
  def yow_days
    yow_yaml = File.expand_path("../../../yow.yaml", __FILE__)
    YAML.load(File.open(yow_yaml))
  end
  
end