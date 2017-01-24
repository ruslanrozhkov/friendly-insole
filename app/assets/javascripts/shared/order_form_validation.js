$(document).ready(function(){
   
    $("#cart-form form").formValidation({
        framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            'options[patient_id]': {
                validators: {
                    notEmpty: {
                        message: 'The patient id is required'
                    }
                }
            },
            'options[age]': {
                validators: {
                    notEmpty: {
                        message: 'The age is required'
                    },
                    integer: {
                        message: 'The age must be a whole number'
                    }
                }
            },
            'options[weight]': {
                validators: {
                    notEmpty: {
                        message: 'The weight is required'
                    },
                    numeric: {
                        message: 'The weight must be a number'
                    }
                }
            },
            'options[shoe_size]': {
                validators: {
                    notEmpty: {
                        message: 'The shoe size is required'
                    },
                    numeric: {
                        message: 'The shoe size must be a number'
                    }
                }
            },
            'options[stl_file_l]': {
                validators: {
                    notEmpty: {
                        message: 'The left foot STL file is required'
                    },
                    file: {
                        message: 'The file must be a *.stl',
                        extension: 'stl'
                    }
                }
            },
            'options[stl_file_r]': {
                validators: {
                    notEmpty: {
                        message: 'The right foot STL file is required'
                    },
                    file: {
                        message: 'The file must be a *.stl',
                        extension: 'stl'
                    }
                }
            },
            'options[csv_file]': {
                validators: {
                    notEmpty: {
                        message: 'The CSV file is required'
                    },
                    file: {
                        message: 'The file must be a *.csv',
                        extension: 'csv'
                    }
                }
            }
        }
    });
    
});