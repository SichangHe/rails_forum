class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.delimiter = [',', ' ', "\n"]
end
