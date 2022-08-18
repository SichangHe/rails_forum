# Parser for act_as_taggable_on.
# Extract all words from string and convert them to lowercase and singlular
class MyParser < ActsAsTaggableOn::GenericParser
  def parse
    ActsAsTaggableOn::TagList.new.tap do |tag_list|
      tag_list.add(@tag_list.split(/[^[[:word:]]]+/).map do |word|
        word.downcase.singularize
      end)
    end
  end
end

class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  ActsAsTaggableOn.default_parser = MyParser
end
