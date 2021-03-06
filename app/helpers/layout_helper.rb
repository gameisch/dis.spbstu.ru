# encoding: utf-8
# Хелперы, которые используются в layout. В основном, связаны с содержимым
# <head>.
module LayoutHelper

  # Добавляет ссылку на jQuery. В production использует сервера Яндекс, во время
  # разработки использует локальную версию.
  def include_jquery
    if Rails.env.production?
      url = 'http://yandex.st/jquery/1.6.4/jquery.min.js'
    else
      url = 'development/jquery-1.6.4.js'
    end
    javascript_include_tag(url)
  end

  # Добавляет дополнительные шрифты
  def include_fonts
    stylesheet_link_tag('http://fonts.googleapis.com/css?family=' +
      'PT+Sans:400,400italic,700&subset=cyrillic,latin&v2')
  end

  # JS-хак, который включает поддержку HTML5-тегов для IE 6—8
  def enable_html5_for_ie
    '<!--[if lt IE 9]>'.html_safe +
      javascript_include_tag('//html5shim.googlecode.com/svn/trunk/html5.js') +
    '<![endif]-->'.html_safe
  end

  # В HTML5 больше не нужно писать type="text/javascript" для <script>.
  # Добавляем хак, который вырезает лишний type из встроенного хелпера.
  def javascript_include_tag(*params)
    super.sub(' type="text/javascript"', '').html_safe
  end

  # В HTML5 больше не нужно писать type="text/css" для <link rel="stylesheet">.
  # Добавляем хак, который вырезает лишний type из встроенного хелпера.
  def stylesheet_link_tag(*params)
    super.sub(' type="text/css"', '').html_safe
  end

end
