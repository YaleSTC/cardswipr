(function (root) {

  /**
   * Widget for adding/removing admins from an event.
   * @constructor
   */
  root.ListManagerWidget = function (config) {
    $rootElem = config.$root;
    this.$select = $rootElem.find('select');
    this.$select.addClass('offscreen');
    this.$options = this.$select.find('option');

    this.headerText = config.header || 'List';
    this.rowTexts = config.rows || [];

    $rootElem.append(this.header())
      .append(this.createList())
      .append(this.createInputRow())
      .append(this.createErrorRow());

    // Bind auto-complete suggestions to the input field
    this.setupTypeahead();

    this.selectedData = null;
  };

  root.ListManagerWidget.prototype = {

    suggestionTemplate: Handlebars.compile('<div><span class="id offscreen">{{id}}</span>{{display}}</div>'),

    /**
     * Header of the widget
     */
    header: function () {
      var $header = $('<label>')
        .attr('for', this.$select.attr('name'))
        .addClass('swipr-list-manager-header')
        .text(this.headerText);
      return $header;
    },

    /**
     * List of existing admins of the event
     */
    createList: function () {
      var that = this;
      var $body = $('<ul>').addClass('swipr-list-manager-list')

      this.$options.each(function (i, option) {
        var $option = $(option);
        var id = $option.val();
        var text = $option.text();
        $body.append(that.createListItem(id, text));
      });
      this.$body = $body;
      return $body;
    },

    /**
     * Input field and add button
     */
    createInputRow: function () {
      var that = this;

      var $row = $('<div>').addClass('input-row');
      var $label = $('<label>').addClass('offscreen')
        .attr('for', 'netid')
        .text('NetID for new event admin');

      this.$input = $('<input>').attr('type', 'text')
        .attr('name', 'netid')
        .attr('placeholder', 'Enter a NetID');

      var $button = $('<button>')
        .addClass('add-button')
        .attr('id', 'swipr-event-admin-add')
        .text('Add admin');

      $button.click(function (ev) {
        ev.preventDefault();
        ev.stopPropagation();
        that.onAddRequest();
      });

      $button.keypress(function (ev) {
        if (ev.keyCode == 13) { // Enter
          ev.preventDefault();
          ev.stopPropagation();
          that.onAddRequest();
        }
      });

      return $row.append($button).append($label).append(this.$input);
    },

    /**
     * Where error messages are displayed.
     */
    createErrorRow: function () {
      this.$error = $('<div>').addClass('error-row').hide();
      return this.$error;
    },

    /**
     * Runs when an input has been submitted by pressing Enter or clicking on
     * the add button.
     */
    onAddRequest: function () {
      var that = this;
      var data = this.selectedData;

      if (!data || !data.id) {
        this.showError('Specified user is not found. Please select from ' +
          'the list of available users that appear as you type. ' +
          'If you cannot find the person you want, make sure s/he has ' +
          'logged into this site at least once to be registered.');
        return;
      }

      if (this.findOptionById(data.id)) {
        this.showError('User is already in the list.');
        return;
      }

      var url = '/users/' + data.id + '.json';
      console.log('URL: ' + url);

      $.ajax('/users/' + data.id + '.json', {
        accepts: 'json',
        success: function (remoteData, textStatus, jqXHR) {
          console.log('Retrieved: ' + JSON.stringify(data));
          if (Array.isArray(data) && data.length == 0) {
            that.showError('User ' + userId + ' not found');
          } else {
            that.addAdmin(data);
          }
        },
        error: function (jqXHR, textStatus, errorThrown) {
          console.log('ListManagerWidget#addAdmin ajax error ' + textStatus);
          that.showError('Sorry, something went wrong with adding the user. ' +
            'Please try again and contact ' +
            '<a href="mailto:dev-mgt@yale.edu">dev-mgt@yale.edu</a> ' +
            'if problem persists.');
        }
      });
    },

    addAdmin: function (userData) {
      this.$error.hide();
      if (this.findOptionById(userData.id)) {
        this.showError('User ' + userData.netid + ' is already in the list.');
      } else {
        this.addOption(userData);
        this.addRow(userData);
      }
    },

    addOption: function (userData) {
      console.log('addoption');
      var $option = $('<option>').attr('selected', 'selected')
        .val(userData.id);
      this.$select.append($option);
    },

    addRow: function (userData) {
      console.log('addrow');
      var fname = userData.nickname || userData.first_name
      var text = fname + ' ' + userData.last_name + ' ' + userData.netid;
      this.$body.append(this.createListItem(userData.id, userData.display));
    },

    createListItem: function (id, text) {
      var that = this;
      var $row = $('<li>').addClass('swipr-list-manager-row');
      var $remove = $('<i>').addClass('swipr-remove fa fa-remove');

      $remove.click(function (ev) {
        var id = $row.data('userId');
        $row.remove();
        that.removeOption(id);
      });

      $row.text(text);
      $row.data('userId', id);
      $row.append($remove);
      return $row;
    },

    findOptionById: function (userId) {
      var found = false;
      this.$options.each(function (i, option) {
        var $option = $(option);
        if ($option.val() == userId) {
          found = true;
          return false; // break out of loop
        }
      });
      return found;
    },

    removeOption: function (userId) {
      this.$options.each(function (i, option) {
        var $option = $(option);
        if ($option.val() == userId) {
          $option.remove();
          return false; // break out of loop
        }
      });
    },

    /**
     * Display error message at the bottom of the widget.
     */
    showError: function (message) {
      var excl = '<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>';
      this.$error.html(excl + ' ' + message);
      this.$error.show();
    },

    /**
     * Set up "Typeahead", an auto-completion library, for the
     * input for "Event Admins".
     */
    setupTypeahead: function () {
      var that = this;

      this.setupBloodhound(function (engine) {
        that.$input.typeahead({
          minLength: 1,
          highlight: true
        },
        {
          name: 'users',
          source: engine,
          display: 'display',
          limit: 10
        });

        that.$input.bind('typeahead:select', function (ev, data) {
          //console.log('Selected: ' + JSON.stringify(data));
          that.selectedData = data;
        });
      });
    },

    /**
     * The suggestion engine "Bloodhound" from typeahead.
     */
    setupBloodhound: function (onSuccess) {
      var engine = new Bloodhound({
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
          url: '/find_users/%QUERY',
          wildcard: '%QUERY'
        }
      });
      var promise = engine.initialize();
      promise
        .done(function () { onSuccess(engine); })
        .fail(function () { console.log('Bloodhound failed to initialize'); });
    }
  };

})(YaleSTC);
