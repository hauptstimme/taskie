module CdnHelper
  CDN_BASE = "https://cdnjs.cloudflare.com/ajax/libs/"

  def cdn_css_tag(*args)
    stylesheet_link_tag *args.map { |stylesheet| [CDN_BASE, stylesheet, ".css"].join }
  end
end
