/* ------------------------------------------------------------------------------
*
*  # Login form with validation
*
*  Specific JS code additions for login_validation.html page
*
*  Version: 1.0
*  Latest update: Aug 1, 2015
*
* ---------------------------------------------------------------------------- */

var baseurl=app_url;//"http://localhost:8080/Blogtrackers/";

$(function() {

	// Style checkboxes and radios
	//$('.styled').uniform();



    $(".form-validate").validate({
        ignore: 'input[type=hidden], .select2-search__field', // ignore hidden fields
        errorClass: 'validation-error-label',
        successClass: 'validation-valid-label',
        highlight: function(element, errorClass) {
            $(element).removeClass(errorClass);
        },
        unhighlight: function(element, errorClass) {
            $(element).removeClass(errorClass);
        },

        // Different components require proper error label placement
        errorPlacement: function(error, element) {

            // Styled checkboxes, radios, bootstrap switch
            if (element.parents('div').hasClass("checker") || element.parents('div').hasClass("choice") || element.parent().hasClass('bootstrap-switch-container') ) {
                if(element.parents('label').hasClass('checkbox-inline') || element.parents('label').hasClass('radio-inline')) {
                    error.appendTo( element.parent().parent().parent().parent() );
                }
                 else {
                    error.appendTo( element.parent().parent().parent().parent().parent() );
                }
            }

            // Unstyled checkboxes, radios
            else if (element.parents('div').hasClass('checkbox') || element.parents('div').hasClass('radio')) {
                error.appendTo( element.parent().parent().parent() );
            }

            // Input with icons and Select2
            else if (element.parents('div').hasClass('has-feedback') || element.hasClass('select2-hidden-accessible')) {
                error.appendTo( element.parent() );
            }

            // Inline checkboxes, radios
            else if (element.parents('label').hasClass('checkbox-inline') || element.parents('label').hasClass('radio-inline')) {
                error.appendTo( element.parent().parent() );
            }

            // Input group, styled file input
            else if (element.parent().hasClass('uploader') || element.parents().hasClass('input-group')) {
                error.appendTo( element.parent().parent() );
            }

            else {
                error.insertAfter(element);
            }
        },
        validClass: "validation-valid-label",
     success: function(label) {
            label.addClass("validation-valid-label").text("Successfully")
        },
        rules: {
            password: {
                minlength: 5
            }
        },
        messages: {
            username: "Enter your username",
        }
    
    });


    // Login form validation
    $("#form_login").validate({
        ignore: 'input[type=hidden], .select2-search__field', // ignore hidden fields
        errorClass: 'validation-error-label',
        successClass: 'validation-valid-label',
        highlight: function(element, errorClass) {
            $(element).removeClass(errorClass);
        },
        unhighlight: function(element, errorClass) {
            $(element).removeClass(errorClass);
        },

        // Different components require proper error label placement
        errorPlacement: function(error, element) {

            // Styled checkboxes, radios, bootstrap switch
            if (element.parents('div').hasClass("checker") || element.parents('div').hasClass("choice") || element.parent().hasClass('bootstrap-switch-container') ) {
                if(element.parents('label').hasClass('checkbox-inline') || element.parents('label').hasClass('radio-inline')) {
                    error.appendTo( element.parent().parent().parent().parent() );
                }
                 else {
                    error.appendTo( element.parent().parent().parent().parent().parent() );
                }
            }

            // Unstyled checkboxes, radios
            else if (element.parents('div').hasClass('checkbox') || element.parents('div').hasClass('radio')) {
                error.appendTo( element.parent().parent().parent() );
            }

            // Input with icons and Select2
            else if (element.parents('div').hasClass('has-feedback') || element.hasClass('select2-hidden-accessible')) {
                error.appendTo( element.parent() );
            }

            // Inline checkboxes, radios
            else if (element.parents('label').hasClass('checkbox-inline') || element.parents('label').hasClass('radio-inline')) {
                error.appendTo( element.parent().parent() );
            }

            // Input group, styled file input
            else if (element.parent().hasClass('uploader') || element.parents().hasClass('input-group')) {
                error.appendTo( element.parent().parent() );
            }

            else {
                error.insertAfter(element);
            }
        },
        validClass: "validation-valid-label",
        messages: {
           username: "Enter your username",
           password: {
           required: "Enter your password",
           minlength: jQuery.validator.format("At least {0} characters required")
            }
        
        },
        
        submitHandler: function(ev)
			{
			console.log("submitted");
                        $("#error_message-box").html('<img src="assets/images/loading.gif" >');
                       // return false;
                        $.ajax({
                        url: baseurl+'login',
						method: 'POST',
						//dataType: 'json',
						data: {
							email: $("input#username").val(),
							password: $("input#password").val(),
                                                        login: "yes",
						},
						error: function(response)
						{						
							console.log(response);
                                                        $("#error_message-box").html('Invalid username/password');
							//alert("An error occoured!");
						},
						success: function(response)
						{       
                                                        console.log(response);
							var login_status = response;//.responseText;
                                                        console.log(login_status);
							if(login_status === "invalid"){
                                                                        $("#error_message-box").html('Invalid username/password');
							}else if(login_status === "success"){
                                                            window.location.href = baseurl+"trackerlist.jsp";
                                                        }
                                                }
                                    });


			}
    });

});
    


function verify(element){
    var id = element.id;
    var content = element.value;
    var field = "";
    if(id==="username_validate"){
        field = "username";
    }else if(id==="email_validate"){
        field = "email";
    }

    if(content==""){
        return false;
    }
     $.ajax({
						url: baseurl+'validate',
						method: 'POST',
						//dataType: 'json',
						data: {
							field:field,
                                                        value:content,
                                                        validate: "yes",
						},
						error: function(response)
						{						
							console.log(response);
                                                        //$("#error_message-box").html('Invalid username/password');
							//alert("An error occoured!");
						},
						success: function(response)
						{       
							var status = response;//.responseText;
                                                        
							if(status === "yes"){
                                                            console.log(status);
                                                            if(field==="username"){
                                                                 $("#user_exist").html('<span class="help-block text-danger"><i class="icon-cancel-circle2 position-left"></i> This username is already taken</span>');
                                                                 $("#user_exist").removeClass("validation-valid-label");
                                                        }
                                                            
                                                            if(field==="email"){
                                                                 $("#email_exist").html('<span class="help-block text-danger" ><i class="icon-cancel-circle2 position-left"></i> This email is already taken</span>');
                                                                 $("#email_exist").removeClass("validation-valid-label");
                                                            }
                                                        }else if(status === "no"){
                                                            console.log(status);
                                                            if(field==="username"){
                                                                $("#user_exist").html('');
                                                                $("#user_exist").addClass("validation-valid-label").text("Available");
                                                             }
                                                            
                                                            if(field==="email"){
                                                                $("#email_exist").html('');
                                                                $("#email_exist").addClass("validation-valid-label").text("Available");
                                                            }
                                                                
                                                        }
                                                }
                                    });
    
}
