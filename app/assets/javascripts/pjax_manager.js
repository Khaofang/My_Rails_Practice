(function(old) {
  $.fn.attr = function() {
    if (arguments.length > 0)
      return old.apply(this, arguments);
    if (this.length === 0)
      return null;
    let obj = {};
    $.each(this[0].attributes, function() {
      if (this.specified)
        obj[this.name] = this.value;
    });
    return obj;
  };
})($.fn.attr);

class PJAXManager {
  constructor(option = {}) {
    $(document).pjax('a:not([data-glazziq-container])', '[data-pjax-container]');

    let self = this;
    $('[data-glazziq-container]').ready(function() {
      let $elements = $(document).find('[data-glazziq-container]');
      let valid_path = /^(\/[\w^ ]+)+\/?([\w.])+[^.]$/;
      let valid_url = /^(ftp|http|https):\/\/[^ "]+$/;

      $elements.each(function(key, element) {
        let $element = $(element);
        let href = $element.attr('href');
        console.log(href);
        if (valid_path.test(href)) {
          let selector = 'a[data-glazziq-container="' + $element.attr('data-glazziq-container') + '"]';
          let targetContainer = $element.attr('data-glazziq-container');
          $(document).pjax(selector, targetContainer);
          console.log(valid_path.test(href));
        }
      });
    });
    $(document).on('pjax:complete', function(event) {
      self.execute();
    });
  }

  execute() {
    this.text = $($(document).find('noscript[meta-tags]')[0]).text();
    this.text = this.text.replace('\n', '');
    this.text = this.text.replace('\r', '');
    this.$noscript = $.parseHTML(this.text);

    let self = this;
    this.$noscript.forEach(function(element) {
      var selector = self.makeSelector(element);
      var relate = $('head').find(selector);
      if (relate.length > 0)
        self.pjaxReplace(relate[0], element);
      else
        $('head').append(element);
    });
  }

  makeSelector(element) {
    let element_attr = $(element).attr();
    let element_var = Object.keys(element_attr);
    let selector = element.tagName;
    element_var.forEach(function(v) {
      if (v !== 'content' && v !== 'href')
        selector = selector + '[' + v + '="' + element_attr[v] + '"]';
    });
    return selector;
  }

  pjaxReplace(tag, element) {
    if ($(element).text() !== '' && $(tag).text() !== '')
      $(tag).text($(element).text());
    let element_attr = $(element).attr();
    let element_var = Object.keys(element_attr);
    element_var.forEach(function(s) {
      $(tag).attr(s, element_attr[s]);
    });
  }

}
