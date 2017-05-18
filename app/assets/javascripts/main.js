window.YaleSTC = {};

(function (root) {

  // Time of previous submission (in milliseconds)
  var lastSubmit = new Date().valueOf();

  $(document).ready(function () {
    $form = $('#swipr-swipe-form');
    if ($form.length > 0) {
      setupSwipeForm($form);
    }

    $eventAdminSelector = $('#swipr-event-admin-selector');
    if ($eventAdminSelector.length > 0) {
      new root.ListManagerWidget({
        $root: $eventAdminSelector,
        header: 'Event Admins',
        rows: ['a', 'b']
      });
    }
  });

  function setupSwipeForm($form) {
    $input = $('#query');
    $input.focus();

    // This callback is to prevent the mag-stripe reader
    // from generating two submits at once
    // because the key sequence contains two "Enter"s.
    // Second submit that is too close to the previous one
    // will be ignored.
    $form.submit(function (ev) {
      var now = (new Date()).valueOf();
      var diff = now - lastSubmit;
      lastSubmit = now;
      return diff > 1000;
    });
  }

})(YaleSTC);
