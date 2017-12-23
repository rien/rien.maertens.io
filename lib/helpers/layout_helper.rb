require 'kramdown'

module LayoutHelper
  def md(text)
    Kramdown::Document.new(text).to_html
  end
end
