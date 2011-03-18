$("#translation-<%= @translation.id %>")
  .hide()
  .find(".translation-destroy")
    .val(true);