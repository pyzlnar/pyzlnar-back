# Virtual Model
#
# Topics are the subjects what most of the models talk about.
# Yes, this could be a table in the DB, but since it would need many intermediate relation tables to
# plug in to several models it just feels more efficient to have it like this.
# At least for now.
module Topic
  TOPICS = %i(
    anime
    gaming
    programming
    personal
  ).freeze

  # Returns the available topics as strings
  def self.topics
    @topics ||= TOPICS.map(&:to_s)
  end
end
