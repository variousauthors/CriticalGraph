[ ] make a model for GephiCSV and move fat controller code into concerns

[ ] incorporate time
[ ] a graph that includes both articles and authors

# NOTES:

## Full Graph

- shows links from authors to articles, and from articles to articles

## Authorship graph

- show the authors who have written more than one article
  with edges to their articles
- does not include reference relationship between vertices

### Display:

for displaying the graph we first apply force atlas with
attraction strength: 1

this cause all the authors to be clumped up with their work,
and pushes authors with more work to the edges

then we rerun force atlas with
attraction strength: 0

which lengthens the edges between author and article

## Author Reference Count Graph

- shows how often an author referred to another article
- "centered" on the object of study, in this case Lana Polanski (@mechapoetic)
- the articles are not shown, so this only gives a sense of who an author reads
  or what authors influence what other authors
- it can also be used as a sort of "political landscape" since some articles/topics become
  how over time.
- it might be useful to do a limited hybrid, in which an article is shown if it
  is referred to extensively

## Hybrid "Trend" Graph

- a hybrid between the "full" author/article graph and the author reference count graph
  that only shows an article if it has sufficient incoming references.
- Rather than centering an author, this graph centers what could be considered
  an "event" or "moment" in the blogosphere.
