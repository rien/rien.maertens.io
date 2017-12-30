module CVHelper
  def stars(amount, max: 3, filled: '★', open: '☆')
    (filled * amount.to_i) + (open * (max - amount.to_i))
  end

  def cv_entry(entry, *keys)
    values = keys.map { |k| md2tex(entry[k].to_s).delete "\n" }
    "\\cventry{#{values.join '}{'}}"
  end

  def latex_proficiencies(proficiencies)
    items = []
    proficiencies.each do |proficiency, values|
      bullets = stars proficiency, filled: '\\FiveStar', open: '\\FiveStarOpen'
      items << "\\item[#{bullets}] #{md2tex values}"
    end

    result = []
    result << '\\begin{itemize}[leftmargin=.5in]' << items << '\\end{itemize}'
    result.join "\n"
  end

  def add_to(contacts, key, icon)
    return unless item[key]
    values = item[key]
    values = [values] unless values.instance_of?(Array)
    values.each do |value|
      contact = { value: value, icon: icon }
      contact[:url] = yield value if block_given?
      contacts << contact
    end
  end
end
