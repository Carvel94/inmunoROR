module PaginateHelper
  class PaginateJSLinkRenderer < WillPaginate::ActionView::LinkRenderer
    def prepare(collection, options, template)

      options[:params] ||= {}
      options[:params]['_'] = nil
      super(collection, options, template)
    end

    protected
    def html_container(html)
      tag(:nav, tag(:ul, html, class: "pagination"))
    end

    def previous_or_next_page(page, text, classname)
      if page
         link(text, page, :class => classname)
      else
        tag(:li, tag(:a, text, class: classname), class: "disabled")
      end
    end

    def page_number(page)
      unless page == current_page
        tag(:li, link(page, page, :rel => rel_value(page)))
      else
        tag(:li, tag(:a, page), class: "active")
      end
    end

    def link(text, target, attributes = {})
      if target.is_a? Fixnum
        attributes[:rel] = rel_value(target)
        target = url(target)
      end

      tag(:li, @template.link_to(text.to_s.html_safe, target, attributes.merge(remote: true)))
    end

    def gap
      tag(:li, tag(:a, '...'))
    end

  end##end of class

  def js_will_paginate(collection, options = {})
    will_paginate(collection, options.merge(:renderer => PaginateHelper::PaginateJSLinkRenderer))
  end
end