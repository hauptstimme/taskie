module CdnHelper
  CDN_BASE = '//cdnjs.cloudflare.com/ajax/libs/'.freeze

  def cdn_css_tag(*args)
    stylesheet_link_tag(*args.map { |stylesheet| [CDN_BASE, stylesheet, ".css"].join })
  end
end
