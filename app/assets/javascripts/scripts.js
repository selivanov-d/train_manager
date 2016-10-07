$(function () {
    var KEY_CODES = {
        enter: 13
    };

    function hide_popover() {
        var rename_trigger = this;

        setTimeout(function () {
            $(rename_trigger).popover('destroy');
        }, 1500);
    }

    function send_request(initial_value) {
        var rename_trigger = this,
            model_id = $(rename_trigger).data('model-id'),
            model_name = $(rename_trigger).data('model-name'),
            name = $(rename_trigger).text();

        if (initial_value === name) return

        $.ajax({
            url: model_name + 's/' + model_id + '/update_name.json',
            method: 'put',
            data: {
                name: name,
                id: model_id
            }
        }).statusCode({
            422: function (response) {
                $(rename_trigger).text(initial_value);

                var errors = JSON.parse(response.responseText);

                $(rename_trigger)
                    .popover({
                        placement: 'top',
                        html: true,
                        content: function () {
                            var errors_html = '<ul>';

                            for (var error_field in errors) {
                                if (errors.hasOwnProperty(error_field)) {
                                    errors[error_field].forEach(function (error) {
                                        errors_html += '<li>' + error + '</li>';
                                    });
                                }
                            }

                            errors_html += '</ul>';

                            return errors_html;
                        }
                    })
                    .popover('show');

                hide_popover.bind(rename_trigger)();
            },
            200: function () {
                $(rename_trigger)
                    .popover({
                        placement: 'top',
                        content: 'Название успешно изменено.'
                    })
                    .popover('show');

                hide_popover.bind(rename_trigger)();
            }
        });
    }

    $('[data-toggle="tooltip"]').tooltip();

    var $rename_triggers = $('.js-admin-routes-index-route-name, .js-admin-trains-index-train-number');
    var initial_value;

    $rename_triggers.on('click', function () {
        initial_value = $(this).text();

        $(this)
            .addClass('-edit-on')
            .removeClass('-edit-off')
            .attr('contenteditable', true)
            .focus();
    });

    $rename_triggers.on('blur', function () {
        $(this)
            .removeClass('-edit-on')
            .addClass('-edit-off')
            .attr('contenteditable', false);

        send_request.bind(this)(initial_value);
    });

    $rename_triggers.on('keydown', function (e) {
        if (e.keyCode === KEY_CODES.enter) {
            $(this).trigger('blur');
        }
    });
});

