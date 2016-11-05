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

p backstories.length

# Set Up Track
track = [{ state: "Frankenisten_Destroyer_Propaganda", array: fd_propaganda}, { state: "Pro_Tech_Propaganda", array: pro_tech_propaganda }, { state: "Missions", array: missions }, { state: "Worldbuilding", array: backstories }]

# set up blank story
story = []

story << "---Introduction---"

number_of_rounds = 4

number_of_rounds.times do |round|
  number_of_checkpoints = track.length
  number_of_checkpoints.times do |checkpoint_index|
    checkpoint = track[checkpoint_index]
    story << "We are now entering the #{checkpoint[:state]} state."
    story << checkpoint[:array].pop
    story << "-----Filler----"
    story
  end
end

story << "---Conclusion---"

puts story