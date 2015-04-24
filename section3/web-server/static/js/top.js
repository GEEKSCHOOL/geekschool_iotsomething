(function() {

    var $on = $('#on');
    var $off = $('#off');
    var $msg = $('#msg');

    $on.click(function() {
        $.ajax({
            url: 'light/on',
            type: 'GET',
            success: function() {
                $off.removeAttr("disabled");
                $on.attr("disabled", "");

                $msg.text("Light is turning on");
            }
        })
    });

    $off.click(function() {
        $.ajax({
            url: 'light/off',
            type: 'GET',
            success: function() {
                $on.removeAttr("disabled");
                $off.attr("disabled", "");

                $msg.text("Light is turning off");
            }
        })
    })

})();
