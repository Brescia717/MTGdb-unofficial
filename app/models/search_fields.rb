class SearchFields
  def types
    Card.select(:types).order('types ASC').uniq.collect.each do |c|
      if c.types.nil?
        next
      else
        types = c.types.delete("[:&,\"]").split().join(" ")
        [types, c.types]
      end
    end
  end

  def legal_formats
    unique_formats = []
    Card.select(:legalities).order('legalities ASC').uniq.collect.each do |c|
      if c.legalities.nil?
        next
      else
        c.legalities.each do |mtg_format, legal|
          if legal == "Legal"
            format_field = mtg_format
            unique_formats << format_field
          end
        end
      end
    end
    unique_formats = unique_formats.sort.uniq
    unique_formats.each do |formats|
      [formats, formats]
    end
  end

  def colors
    ['Black','Blue','White','Red','Green']
  end
end
