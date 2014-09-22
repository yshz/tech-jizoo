module ArticlesHelper
  def article_permalink(article)
    published_at = article.published_at
    title = article.title.downcase.sub(/\s/, '-')
    options = {
      year: published_at.strftime('%Y'),
      month: published_at.strftime('%m'),
      day: published_at.strftime('%d'),
      title: title
    }
    article_path(options)
  end

  def article_title(article)
    if article.present?
      strip_tags(article.title)
    else
      nil
    end
  end
end
