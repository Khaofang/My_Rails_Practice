module ApplicationHelper
  def default_meta_tags
    {
      title:        @title,
      description:  @description,
    }
  end
end
