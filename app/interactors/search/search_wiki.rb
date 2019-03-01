require 'wikipedia'
module Search
  class SearchWiki
    include Interactor
    def call
      string = context.string
      search(string)
    end

    def search(string)
      info = Wikipedia.find("#{string}")
      context.title = info.title
      context.description = info.text
    end
  end
end