module DiffHelper

  def file_lines(line)
    if line.addition?
      return ["+", HTML.escape(line.content)].join(" ")
    elsif line.deletion?
      return ["-", HTML.escape(line.content)].join(" ")
    else
      return ["+-", HTML.escape(line.content)].join(" ")
    end
  end

  def line_color(line)
    if line.addition?
      return "bg-green-200 text-green-700 overflow-scroll"
    elsif line.deletion?
      return "bg-red-200 text-red-700 overflow-scroll"
    else
      return "bg-orange-200 text-orange-700 overflow-scroll"
    end
  end

end
