# NOTE: this is a GephiCSV controller, not just a CSV
# controller. CSV is a format more general than GephiCSV
# and that's why this gets its own controller. The pattern
# here is one controller per consumer of exports
# later it may make sense to have consumer and format
# passed in as variables, but for now I imagine that
# each export will require constructing a very different
# data structure
class Graph::GephiCsvController < ApplicationController
  def create
    # get all the authors alphabetically
    # build a matrix in memory!

    respond_to do |format|
      format.csv { send_data(full_graph) }
    end
  end

  def author_graph
    # TODO replace the GSUBs with a way of quoting strings that GePHI can handle...
    authors = Author.alphabetically
    handles = authors.map(&:handle)

    adjacency_matrix = authors.map do |author|
      # count the number of outgoing edges to each other author
      # in a histogram
      references = author.articles.reduce(Hash.new(0)) do |memo, article|
        # edges from an article to a referenced author
        article.references.each do |ref|
          memo[ref.author.handle] += 1
        end

        memo
      end

      # apparently gephi can't handle bare words in its csv import
      # TODO for now we are subbing _ characters, but I'd like to figure
      # out how to just use string literals
      #
      # this builds a row like [name, 1, 0, 3, 8] where each entry is the count
      # of references to that column's author
      adjacencies = handles.reduce([author.handle.gsub(" ", "_")]) do |memo, handle|
        memo << references[handle]

        memo
      end

      adjacencies
    end

    handles = handles.map { |handle| handle.gsub(" ", "_") }

    gephi_csv = CSV.generate(col_sep: ";") do |csv|
      # the first row is like [_, name, name, ...]
      # to mark the columns
      csv << handles.prepend(nil)

      adjacency_matrix.each do |row|
        csv << row
      end
    end

    gephi_csv
  end

  def full_graph
    # the adj matrix will have 4 quandrants:
    # authors to articles | articles to authors is symmetrical
    # articles to articles is DAG
    #
    # AUTH is N
    # ARTI is M
    #
    # structure
    #      AUTH ARTI
    # AUTH 0000 A--R
    # ARTI R--A R->R <-- this is DAG
    #
    # dimensions
    #      AUTH ARTI
    # AUTH  NxN  NxM
    # ARTI  MxN  MxM

    # TODO: so should we construct the parts and the put them together?
    # TODO replace the GSUBs with a way of quoting strings that GePHI can handle...
    authors = Author.alphabetically
    handles = authors.map(&:handle) # N
    article_ids = Article.all.map(&:id) # M

    # size: M x M
    article_to_article = Article.all.map do |article|

      references = article.references.reduce(Hash.new(0)) do |memo, ref|
        # edges from an article to other articles
        memo[ref.id] += 1

        memo
      end

      # turns the hash of {id: count} pairs into an array indexed
      # by the article_ids
      adjacencies = article_ids.reduce([]) do |memo, id|
        memo << references[id]

        memo
      end

      adjacencies
    end

    # size: N x M
    author_to_article = authors.map do |author|
      # count the number of outgoing edges to each article
      references = author.articles.reduce(Hash.new(0)) do |memo, article|
        # edges from an author to her articles
        memo[article.id] += 1

        memo
      end

      # turns the hash of {id: count} pairs into an array indexed
      # by the article_ids
      adjacencies = article_ids.reduce([]) do |memo, id|
        memo << references[id]

        memo
      end

      adjacencies
    end

    # size: M x N
    article_to_author = author_to_article.transpose

    # size: N x N
    zeroes = zeroes(handles.length)

    handles = handles.map { |handle| handle.gsub(" ", "_") }

    # we want to augment these matrices all together,
    # but they are not matrices, they are arrays so...
    adjacency_matrix = (zeroes(handles.length).zip author_to_article).map(&:flatten) + (article_to_author.zip article_to_article).map(&:flatten)

    gephi_csv = CSV.generate(col_sep: ";") do |csv|
      # the first row is like [_, name, name, ...]
      # to mark the columns
      labels = handles + article_ids
      csv << [nil] + labels

      adjacency_matrix.each_with_index do |row, index|
        csv << row.prepend(labels[index])
      end
    end

    gephi_csv
  end

  def authorship_graph
    # the adj matrix will have 4 quandrants:
    # authors to articles | articles to authors is symmetrical
    # the rest is zeroes
    #
    #      AUTH ARTI
    # AUTH 0000 A--R
    # ARTI R--A 0000

    # TODO: so should we construct the parts and the put them together?
    # TODO replace the GSUBs with a way of quoting strings that GePHI can handle...
    authors = Author.alphabetically
    handles = authors.map(&:handle)
    article_ids = Article.all.map(&:id)

    author_to_article = authors.map do |author|
      # count the number of outgoing edges to each article
      references = author.articles.reduce(Hash.new(0)) do |memo, article|
        # edges from an article to a referenced
        memo[article.id] += 1

        memo
      end

      # apparently gephi can't handle bare words in its csv import
      # TODO for now we are subbing _ characters, but I'd like to figure
      # out how to just use string literals
      #
      # this builds a row like [name, 1, 0, 3, 8] where each entry is the count
      # of references to that column's author
      adjacencies = article_ids.reduce([]) do |memo, id|
        memo << references[id]

        memo
      end

      adjacencies
    end

    article_to_author = author_to_article.transpose

    handles = handles.map { |handle| handle.gsub(" ", "_") }

    # we want to augment these matrices all together,
    # but they are not matrices, they are arrays so...
    adjacency_matrix = (zeroes(handles.length).zip author_to_article).map(&:flatten) + (article_to_author.zip zeroes(article_ids.length)).map(&:flatten)

    gephi_csv = CSV.generate(col_sep: ";") do |csv|
      # the first row is like [_, name, name, ...]
      # to mark the columns
      labels = handles + article_ids
      csv << [nil] + labels

      adjacency_matrix.each_with_index do |row, index|
        csv << row.prepend(labels[index])
      end
    end

    gephi_csv
  end

  def zeroes(n, m = n)
    [[0] * m] * n
  end

end
