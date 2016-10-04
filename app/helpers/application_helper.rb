module ApplicationHelper
  def bs_icon(klass, options)
    if options[:tooltip]
      tag 'i', class: "glyphicon glyphicon-#{klass}", data: { toggle: 'tooltip', 'original-title': options[:tooltip] }
    else
      tag 'i', class: "glyphicon glyphicon-#{klass}"
    end
  end
end
