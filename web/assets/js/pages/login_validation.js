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
<<<<<<< HEAD

=======
var baseurl=app_url;//"http://localhost:1010/Tracker/";
>>>>>>> 24be98068c766af2f18ff4a1434ce0060b214fd0
$(function() {

	// Style checkboxes and radios
	$('.styled').uniform();


    // Setup validation
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
<<<<<<< HEAD
            password: {
            	required: "Enter your password",
            	minlength: jQuery.validator.format("At least {0} characters required")
            }
        }
=======
            password: "Enter your password"
        },
        
        submitHandler: function(ev)
			{
			console.log("submitted");
                        $("#error_message-box").html('<img src="assets/images/loading.gif" >');
                       // return false;
                        $.ajax({
						url: baseurl+'Login',
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
                                                            window.location.href = baseurl+"dashboard.jsp";
                                                        }
                                                }
                                    });


			}
>>>>>>> 24be98068c766af2f18ff4a1434ce0060b214fd0
    });

});
