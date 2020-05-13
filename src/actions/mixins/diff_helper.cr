module DiffHelper
  def file_lines(line)
    if line.mode == GitDiffParser::Line::Mode::Modified
      return [HTML.escape(line.content)].join(" ")
    elsif line.deletion?
      return [HTML.escape(line.content)].join(" ")
    else
      return [HTML.escape(line.content)].join(" ")
    end
  end

  def line_color(line)
    if line.mode == GitDiffParser::Line::Mode::Modified
      return "bg-green-200 text-green-800"
    elsif line.mode == GitDiffParser::Line::Mode::Removed
      return "bg-red-200 text-red-800"
    else
      return "overflow-scroll"
    end
  end

  def line_color_bg(line)
    if line.mode == GitDiffParser::Line::Mode::Modified
      return "bg-green-200"
    elsif line.mode == GitDiffParser::Line::Mode::Removed
      return "bg-red-200"
    else
      return "bg-gray-400"
    end
  end
end
