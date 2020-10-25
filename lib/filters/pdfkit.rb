require 'byebug'
module Nanoc::Filters
  class PDFKit < Nanoc::Filter
    identifier :pdfkit
    type :text => :binary

    require 'pdfkit'

    def style_tag(identifier)
      item = items[identifier]
      raise "Could not found item with identifier #{identifier}" if item.nil?
      "<style>#{item.compiled_content}</style>"
    end

    def inline_styles(content, style_items)
      style_tags = style_items.map{ |item| style_tag(item) }.join("\n")
      content.gsub('</head>', style_tags + '</head>')
    end

    def run(content, params = {})
      if params[:style_items]
        params = Hash.new.merge!(params)
        style_items = params.delete(:style_items)
        content = inline_styles(content, style_items)
      end
      params[:enable_local_file_access] = true
      ::PDFKit.new(content, **params).to_file(output_filename)
    end
  end
end
