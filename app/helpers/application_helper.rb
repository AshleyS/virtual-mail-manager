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

    if params[:controller] == "users" then
      nav << "<li>" + link_to("Users", users_path, :class => "current") + "</li>"
    else
      nav << "<li>" + link_to("Users", users_path) + "</li>"
    end

    nav << "
      </ul>
    "

    nav
  end

end
