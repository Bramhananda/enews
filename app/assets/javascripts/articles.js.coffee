# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  split = (val) ->
    val.split /,\s*/
  extractLast = (term) ->
    split(term).pop()
  availableTags =$('#form-field-tags').data('autocomplete-source')

  # don't navigate away from the field on tab when selecting an item
  $("#form-field-tags").bind("keydown", (event) ->
    event.preventDefault()  if event.keyCode is $.ui.keyCode.TAB and $(this).data("ui-autocomplete").menu.active
  ).autocomplete
    minLength: 0
    messages: {
    noResults: '',
    results: ->
    }
    source: (request, response) ->


      # delegate back to autocomplete, but extract the last term
      response $.ui.autocomplete.filter(availableTags, extractLast(request.term))

    focus: ->

      # prevent value inserted on focus
      false

    select: (event, ui) ->
      terms = split(@value)

      # remove the current input
      terms.pop()

      # add the selected item
      terms.push ui.item.value

      # add placeholder to get the comma-and-space at the end
      terms.push ""
      @value = terms.join(", ")
      false

