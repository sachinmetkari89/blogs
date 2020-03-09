module ArticlesHelper

  def article_with_label(state)
    case state
    when Article::DRAFT
      return "<span class='badge badge-pill badge-dark'>Draft</span>".html_safe
    when Article::PUBLISHED
      return "<span class='badge badge-pill badge-info'>Published</span>".html_safe
    when Article::ARCHIVED
      return "<span class='badge badge-pill badge-success'>Archived</span>".html_safe
    else
      return ""
    end
  end

  def article_state_options
    return [['Draft', 'draft'], ['Published', 'published'], ['Archived', 'archived']]
  end

  def category_options
    @categories = Category.all
  end

  def field_flash_messages(errors, field_name)
    if errors.present?
      return errors && errors[field_name] && errors[field_name].join(", ")
    end
    return ''
  end

end
