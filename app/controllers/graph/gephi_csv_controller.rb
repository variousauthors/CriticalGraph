class Graph::GephiCsvController < ApplicationController
  def create
    # get all the authors alphabetically
    # build a matrix in memory!

    # TODO replace the GSUBs with a way of quoting strings that GePHI can handle...
    authors = Author.alphabetically
    handles = authors.map(&:handle)

    graph = authors.map do |author|
      references = author.articles.reduce(Hash.new(0)) do |memo, article|
        article.references.each do |ref|
          memo[ref.author.handle] += 1
        end

        memo
      end

      # apparently gephi needs strings marked up like "this one,"etc etc,
      handles.reduce([author.handle.gsub(" ", "_")]) do |memo, handle|
        memo << references[handle]

        memo
      end
    end

    handles = handles.map { |handle| handle.gsub(" ", "_") }
    Rails.logger.debug(handles)
    graph = CSV.generate(col_sep: ";") do |csv|
      csv << handles.prepend(nil)

      graph.each do |node|
        csv << node
      end
    end

    respond_to do |format|
      format.csv { send_data(graph) }
    end
  end
end
