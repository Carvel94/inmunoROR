$(function($) {

$("#usuario_telefono_habitacion").mask("(0299) 999-9999");
$("#usuario_telefono_trabajo").mask("(0299) 999-99-99");
$("#usuario_celular1").mask("(0499) 999-99-99");
$("#usuario_celular2").mask("(0499) 999-99-99");
$("#usuario_historia").mask("999?999");
$("#usuario_fecha_nacimiento").mask("99-99-9999");
$("#usuario_ava").mask("999");
$("#usuario_cuc").mask("999");
$("#usuario_hong").mask("999");
$("#usuario_berm").mask("999");
$("#usuario_john").mask("999");
$("#usuario_asp").mask("999");
$("#usuario_blom").mask("999");
$("#usuario_cedula").mask("99999?9999");
$("#contacto_telefono_local").mask("(0999) 999-9999");
$("#contacto_telefono_celular").mask("(0499) 999-99-99");


$('#paciente_datoBuscar').qtip({
    suppress: false,
    content: {
        text: 'Puede colocar un correo electrónico, un número de cédula, nombre o apellido, o el número en tratamiento del paciente a buscar'
    },
    style: {
        classes: 'qtip-rounded qtip-shadow'
    }
})


$('#usuario_nombre').qtip({
    suppress: false,
    content: {
        text: 'El nombre del usuario no puede tener número o caracteres especiales'
    },
    style: {
        classes: 'qtip-rounded qtip-shadow'
    },
    show: {
        event: 'blur'
    },
    events: {
        show: function(event, api) {
            var re = /^([a-zA-Z ñáéíóú]{2,60})$/;
            //console.log($(this).val());
            
            if (!re.test($('#usuario_nombre').val())){
                $('#usuario_nombre').val("");
            }
            else
                event.preventDefault();
        }
    }

})



$('#usuario_email').qtip({
    suppress: false,
    content: {text: 'El email colocado no es valido'},
    style: {classes: 'qtip-rounded qtip-shadow'},
    show: {event: 'blur'},
    hide: {event: 'focus'},
    events: {
        show: function(event, api) {
            var re = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;
            if ($('#usuario_email').val().trim() != "" && re.test($('#usuario_email').val())){
                event.preventDefault();
            }
            else
                if ($('#usuario_email').val().trim() == "" )
                     event.preventDefault();
        },
         hide: function(event, api) {
                $('#usuario_email').val("");
        }
    }
})


$('#usuario_email_confirmation').qtip({
    suppress: false,
    content: {text: 'El email colocado no es valido'},
    style: {classes: 'qtip-rounded qtip-shadow'},
    show: {event: 'blur'},
    hide: {event: 'focus'},
    events: {
        show: function(event, api) {
            var re = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;
            if ($('#usuario_email_confirmation').val().trim() != "" && re.test($('#usuario_email_confirmation').val())){
                event.preventDefault();
            }
            else
                if ($('#usuario_email_confirmation').val().trim() == "" )
                     event.preventDefault();
        },
         hide: function(event, api) {
                $('#usuario_email_confirmation').val("");
        }
    }

})


$('#usuario_email2').qtip({
    suppress: false,
    content: { text: 'El email colocado no es valido' },
    style: {classes: 'qtip-rounded qtip-shadow'},
    show: {event: 'blur'},
    hide: {event: 'focus'},
    events: {
        show: function(event, api) {
            var re = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;
            if ($('#usuario_email2').val().trim() != "" && re.test($('#usuario_email2').val())){
                event.preventDefault();
            }
            else
                if ($('#usuario_email2').val().trim() == "" )
                     event.preventDefault();
        },
         hide: function(event, api) {
                $('#usuario_email2').val("");
        }
    }
})

$('#usuario_email2_confirmation').qtip({
    suppress: false,
    content: { text: 'El email colocado no es valido' },
    style: {classes: 'qtip-rounded qtip-shadow'},
    show: {event: 'blur'},
    hide: {event: 'focus'},
    events: {
        show: function(event, api) {
            var re = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;
            if ($('#usuario_email2_confirmation').val().trim() != "" && re.test($('#usuario_email2_confirmation').val())){
                event.preventDefault();
            }
            else
                if ($('#usuario_email2_confirmation').val().trim() == "" )
                     event.preventDefault();
        },
         hide: function(event, api) {
                $('#usuario_email2_confirmation').val("");
        }
    }
})


$('#datetimepicker1').datetimepicker({
    locale: 'es',
    format: 'DD-MM-YYYY',
    defaultDate: new Date()
    });

$('#datetimepicker2').datetimepicker({
    locale: 'es',
    format: 'DD-MM-YYYY',
    defaultDate: new Date()
    });

if ($('#usuario_username').val().trim() == "") { 
    $('#usuario_username').val("alerasin"+$("#usuario_numero_excel").val());
    $("#usuario_historia").blur(function(){
        $('#usuario_username').val("alerasin"+$("#usuario_numero_excel").val());
    });
}

var pruebasBol = false;


$("#botonPruebas").click(function(){
    if ($('#pruebas').css('display') == 'none') 
        $("#pruebas").show();
    else
        $("#pruebas").hide();
});

$("#usuario_telefono_habitacion").on("blur", function() {


    var last = $(this).val().substr( $(this).val().indexOf("-") + 1 );
    if( last.length == 3 ) {
        var move = $(this).val().substr( $(this).val().indexOf("-") - 1, 1 );
        var lastfour = move + last;
        
        var first = $(this).val().substr( 0, 9 );
        
        $(this).val( first + '-' + lastfour );
    }
});



$("#administrator_menu_nivel0_menu_nivel1_titulo").keyup(function(){
    el = $(this);
    if(el.val().length >= 24){
        el.val( el.val().substr(0, 24) );
    } else {
        $("#charNum").text(24-el.val().length);
    }
});


});

