module CategoriesHelper
  
  def render_cat hash, options = {}, &block
    sort_proc = options.delete :sort
    content_tag :tr, options do
      content_tag :td do
        hash.keys.sort_by(&sort_proc).each do |node|
          block.call node, render_tree(hash[node], :sort => sort_proc, &block)
        end
      end
    end if hash.present?
  end
  
  def display_node(node)
    html = ""
    if node.level
      html << "-" * node.level
    end
    html << " #{node.name}"
  end
  
  def display_sort_category_link(node)
    link_to(t('categories.links.sort'), sort_category_path(node)) if node.children.size > 1
  end
  
  def display_edit_category_link(node)
    link_to(t('categories.links.edit'), edit_category_path(node)) unless node.name == 'root'
  end
  
end
