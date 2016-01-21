module MarkdownHelper
  def markdown(text)
    renderer = Redcarpet::IntercityHtml.new(
      with_toc_data: true,
      hard_wrap: true,
      safe_links_only: false)

    @markdown_helper ||= Redcarpet::Markdown.new(renderer, autolink: true,
                                                           space_after_headers: true, hard_wrap: true,
                                                           disable_indented_code_blocks: true,
                                                           fenced_code_blocks: true)
    @markdown_helper.render(text).html_safe
  end
end
