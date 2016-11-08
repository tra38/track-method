require 'yaml'
require 'pry'

information = YAML.load(File.open("data.yml"))

speech_intros = YAML.load(File.open("introductions.yml"))

filler_text = YAML.load(File.open("phrases.yml"))

# Extract from corpus and save in variables
def extract_paragraphs(hash)
  array = []
  hash.keys.each do |key|
    array << hash[key]["Paragraphs"]
  end
  new_array = array.flatten.shuffle
  add_line_breaks(new_array)
end

def add_line_breaks(array)
  array.map do |paragraph|
    paragraph.gsub("\n", "\n\n")
  end
end

fd_propaganda = extract_paragraphs(information["Frakenstein_Destroyer_Propaganda"])
pro_tech_propaganda = extract_paragraphs(information["Pro_Tech_Propaganda"])
missions = extract_paragraphs(information["Missions"])
backstories = extract_paragraphs(information["Worldbuilding"])


# Set up introductory speech from fd and pro tech
fd_introductions = extract_paragraphs(speech_intros["Frakenstein_Destroyer_Propaganda"])
pro_tech_introductions = extract_paragraphs(speech_intros["Pro_Tech_Propaganda"])

#Set up filler text
filler_text = extract_paragraphs(filler_text["Phrases"])

# Set Up Track
track = [{ state: "Frakenstein_Destroyer_Propaganda", array: fd_propaganda }, { state: "Pro_Tech_Propaganda", array: pro_tech_propaganda }, { state: "Missions", array: missions }, { state: "Worldbuilding", array: backstories }]

# set up blank story
story = []

story << "My name is Derek-R. I live in Alpha Complex, a dystopian dictatorship led by a insane supercomputer that calls itself The Computer. Technology has run rampant, utterly destroying and dehumanizing all those in its wake. In the night, I worked with the Frakenstein Destroyers, a secret society composed of Luddites, bent on overthrowing Alpha Complex. I serve as their loyal propagandist. The Frakenstein Destroyers is an illegal secret society, outlawed by The Computer. But we do not fear The Computer. It will be smashed, like all forms of technological oppression.\n\nBut I'm only working for the Frakenstein Destroyers in the night. In the day, I worked with the Pro Tech society, another illegal secret society, this one composed of technocrats and scientists. This group believes in controlling and manipulating The Computer, to modify its source code to further technological research. The Computer is afraid of being controlled by fallible humans, and want to destroy us...just as much as the Frakenstein Destroyers. But we do not fear The Computer. The Computer is nothing more than a pawn in our game to uplift humanity using the power of technology and science.\n\nTo work with two rival secret societies, at the same time, without them ever noticing, is a very dangerous thing. But I'm a man who is ready for danger. There are many illegal organizations within Alpha Complex, and these illegal organizations have wormed their way into the highest ranks of power. There are rumors that even some of our High Programmers are secretly members of these illegal societies. If I want power, I have to align with the treasonous...\n\n...and it is my alignment with treason that makes me well-suited to working with The Computer as a Troubleshooter. The Troubleshooters are the elite agents, able to do the tasks nobody else want to. Their goal is to find trouble and shoot it, and I am able to do so effectively, due to my connections with both the Frakenstein Destroyers and the Pro Tech. And while I may betray The Computer in secret, I am happy to shoot all traitors who are not working for my secret societies. I am a very loyal agent to The Computer, and I am proud of my loyalty...\n\nAnd finally, I have a normal, boring job, just like everyone else. Every citizen has a right to a Basic Income along with make-work. Robots do most of the work, but humans need the illusion of meaning, and so my job. I am a History Purifier. Alpha Complex has an Official History, a true History, but there are many Unofficial Histories that must be purged for bringing into disrepute the true History. Internal Security will give me some papers, and my job is to burn them. It's a very rewarding job, as it makes me feel that I am contributing to the well-being of Alpha Complex.\n\nAnd I keep up my routine, serving The Computer while secretly betraying it, for a period of time."

story << "\n--------------\n"

number_of_rounds = 4

number_of_rounds.times do |round|
  number_of_checkpoints = track.length
  number_of_checkpoints.times do |checkpoint_index|
    checkpoint = track[checkpoint_index]
    # story << introductory_paragraphs(checkpoint[:state])
    case checkpoint[:state]
    when "Frakenstein_Destroyer_Propaganda"
      story << fd_introductions.pop
    when "Pro_Tech_Propaganda"
      story << pro_tech_introductions.pop
    else
      # We already have transition phrases embeded within the corpus
      # story << "We are now entering the #{checkpoint[:state]} state.\n\n"
    end
    story << checkpoint[:array].pop
    story << filler_text.pop
    story << "--------------\n"
  end
end

story << "I heard footsteps. The Computer has discovered my treason. It has just now learned of my membership to the Pro Tech and Frakenstein Destroyers, and have sent Internal Security agents to  terminate me before I can do any more damage. The rat who betrayed me? Charlie, the elite commando who I recruited long ago. Charlie knew that to advance in this corrupt society, one has to be willing to betray their closest friends. I can't blame him, considering that I had betrayed him so long ago.\n\nI can hear the footsteps of the Internal Security agents coming, their superlasers being charged up. The Pro Techers and the  Frakenstein Destroyers didn't care about me...they only used me for propaganda purposes, and decided that keeping me as a Holy Martyr would serve their purposes much cheaper than trying to bail me out. So I am alone, up against The Computer.\n\nBut I am not afraid of The Computer. I wanted power, and that was why I betrayed The Computer. But now I realize that all I really wanted was the bliss of oblivion."

puts story.join