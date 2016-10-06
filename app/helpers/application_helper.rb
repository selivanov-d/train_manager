module ApplicationHelper
  def bs_icon(klass, options)
    if options[:tooltip]
      tag 'span', class: "glyphicon glyphicon-#{klass}", data: { toggle: 'tooltip', 'original-title': options[:tooltip] }
    else
      tag 'span', class: "glyphicon glyphicon-#{klass}"
    end
  end
end
