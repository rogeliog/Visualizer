module ApplicationHelper
  def map_index?
    params[:controller] == 'maps' and params[:action] == 'index'
  end
end
