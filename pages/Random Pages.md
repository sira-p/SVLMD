icon:: 🎲
exclude-from-graph-view:: true

- # 10 Random Pages to Read
- {{query (and (sample 10) (page-property :author) (not (page-property :exclude-from-graph-view "true")))}}
  query-sort-by:: page
  query-sort-desc:: false
  query-properties:: [:icon :page :alias :author]