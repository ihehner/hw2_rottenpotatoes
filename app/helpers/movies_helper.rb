module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def sortable(column, title)
    css_class = column == sort_column ? 'hilite' : nil
    link_to title, {:sort => column}, {:class => css_class}
  end
end
