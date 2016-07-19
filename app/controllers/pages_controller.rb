class PagesController < ApplicationController
  def home
    @parser = ParserAction.new
    
    @full_name = @parser.full_name
  end
end
