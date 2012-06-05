$(function () {
        function find_container(input) {
            return input.parent().parent();
        }
        function remove_validation_markup(input) {
            var cont = find_container(input);
            cont.removeClass('error success warning');
            $('.help-inline.error, .help-inline.success, .help-inline.warning',
                cont).remove();
        }
        function add_validation_markup(input, cls, caption) {
            var cont = find_container(input);
            cont.addClass(cls);
            input.addClass(cls);
                
            if (caption) {
                var msg = $('<span class="help-inline"/>');
                msg.addClass(cls);
                msg.text(caption);
                input.after(msg);
            }       
        }
        function remove_all_validation_markup(form) {
            $('.help-inline.error, .help-inline.success, .help-inline.warning',
                form).remove(); 
            $('.error, .success, .warning', form)
                .removeClass('error success warning');
        }               
        $('form').each(function () {
            var form = $(this);
                    
            form
                .validator({
                })
                .bind('reset.validator', function () {
                    remove_all_validation_markup(form);
                })
                .bind('onSuccess', function (e, ok) {
                    $.each(ok, function() {
                        var input = $(this);
                        remove_validation_markup(input);
                        // uncomment next line to highlight successfully
                        // validated fields in green
                        //add_validation_markup(input, 'success');
                    }); 
                })
                .bind('onFail', function (e, errors) {
                    $.each(errors, function() {
                        var err = this;
                        var input = $(err.input);
                        remove_validation_markup(input);
                        add_validation_markup(input, 'error',
                            err.messages.join(' '));
                    });
                    return false;
                });
        });
    });
