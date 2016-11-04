require 'yaml'

information = YAML.load(File.open("data.yml"))

# Extract from corpus and save in variables
def extract_paragraphs(hash)
  array = []
  hash.keys.each do |key|
    array << hash[key]["Paragraphs"]
  end
  array.flatten.shuffle
end

fd_propaganda = extract_paragraphs(information["Frankenisten_Destroyer_Propaganda"])
pro_tech_propaganda = extract_paragraphs(information["Pro_Tech_Propaganda"])
missions = extract_paragraphs(information["Missions"])
backstories = extract_paragraphs(information["Worldbuilding"])

# Set Up Track
track = [fd_propaganda, pro_tech_propaganda, missions, backstories]

# set up blank story
story = []

number_of_rounds = 4

number_of_rounds.times do |round|
  number_of_checkpoints = track.length
  number_of_checkpoints.times do |checkpoint_index|
    checkpoint = track[checkpoint_index]
    story << checkpoint.pop
  end
end

puts story