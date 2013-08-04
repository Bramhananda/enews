(function() {
  $(function() {
    var availableTags, extractLast, split;
    split = function(val) {
      return val.split(/,\s*/);
    };
    extractLast = function(term) {
      return split(term).pop();
    };
    availableTags = $('#form-field-tags').data('autocomplete-source');
    return $("#form-field-tags").bind("keydown", function(event) {
      if (event.keyCode === $.ui.keyCode.TAB && $(this).data("ui-autocomplete").menu.active) {
        return event.preventDefault();
      }
    }).autocomplete({
      minLength: 0,
      messages: {
        noResults: '',
        results: function() {}
      },
      source: function(request, response) {
        return response($.ui.autocomplete.filter(availableTags, extractLast(request.term)));
      },
      focus: function() {
        return false;
      },
      select: function(event, ui) {
        var terms;
        terms = split(this.value);
        terms.pop();
        terms.push(ui.item.value);
        terms.push("");
        this.value = terms.join(", ");
        return false;
      }
    });
  });

}).call(this);
