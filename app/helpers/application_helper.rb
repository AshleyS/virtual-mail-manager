module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def build_nav_menu

    nav = "
      <ul>
        "

    if params[:controller] == "application" then
      nav << '<li>' + link_to("Home", root_path, :class => "current") + '</li>'
    else
      nav << "<li>" + link_to("Home", root_path) + "</li>"
    end

    if params[:controller] == "domains" || params[:controller] == "mailboxes" || params[:controller] == "mailaliases" then
      nav << "<li>" + link_to("Domains", domains_path, :class => "current") + "</li>"
    else
      nav << "<li>" + link_to("Domains", domains_path) + "</li>"
    end

    if admin?
      if params[:controller] == "users" then
        nav << "<li>" + link_to("Users", users_path, :class => "current") + "</li>"
      else
        nav << "<li>" + link_to("Users", users_path) + "</li>"
      end
    end

    nav << "
      </ul>
    "

    nav
  end

  def get_percentage(current, max)
    if max == 0 then
      percentage = 100
    elsif max == -1 then
      percentage = 0
    else
      divide     = current.to_f / max.to_f
      percentage = (divide.to_f * 100).to_i
    end
    percentage
  end

  def build_progress_bar(current, max)
    
    percentage = get_percentage(current, max)

    colour = determine_colour_from_percentage( percentage )

    content = '
      <div style="width:125px;padding:2px;background-color:white;border:1px solid #006400;text-align:center;border-radius: 4px">
        <div style="width:' + percentage.to_s + '%;background-color:' + colour.to_s + ';border-radius: 4px">
          ' + percentage.to_s + '%
        </div>
      </div>
    '

    content
  end

  def determine_colour_from_percentage( percentage )
    if percentage >= 75 then
      "red"
    elsif percentage >= 50 then
      "orange"
    else
      "lightgreen"
    end
  end

  def infinite_or_number(number)
    if number == -1 then
      "&infin;"
    else
      number
    end
  end

end
