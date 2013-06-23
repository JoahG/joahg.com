atom_feed do |feed|
  feed.title "Blog | JoahG.com"
  feed.updated @posts.first.created_at
  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title post.title
      entry.content post.rendered, :type => 'html'
      entry.author post.user.name
    end
  end
end