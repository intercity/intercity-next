class Redcarpet::IntercityHtml < Redcarpet::Render::HTML
  def initialize(options = {})
    @options = options.dup
    super options
  end

  def block_code(code, language)
    <<-HTML

<div class="highlight">
  <pre><code class="#{language}">#{code}</code></pre>
</div>

    HTML
  end
end
