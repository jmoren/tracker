module ApplicationHelper

  def title_hlp(opcion)
    case opcion
      when 1;  title = "To Do "
      when 2;  title = "Progress"
      when 3;  title = "Done"
    end
    return title
  end

end
