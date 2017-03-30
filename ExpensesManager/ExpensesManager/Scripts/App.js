'use strict';

var incomstUrl = "../_api/lists/getbytitle('Incomsters')/items";
var paymentUrl = "../_api/lists/getbytitle('Payments')/items";
var categoryUrl = "../_api/lists/getbytitle('Categories')/items";

$(document).ready(function () {
    moment.locale('sv');

    // Get totals
    var totalIncomes = 0;
    var totalPayments = 0;

    getTotalIncomes(incomstUrl)
        .done(function (data) {
            var result = data.d.results;

            for (var i = 0; i < result.length; i++) {
                totalIncomes += result[i].Amount;
            }

            $('#totalIncomster').append(totalIncomes);
        }).fail(function (error) {
            console.log(JSON.stringify(error));
        });

    getTotalPayment(paymentUrl)
        .done(function (data) {
            var result = data.d.results;

            for (var i = 0; i < result.length; i++) {
                totalPayments += result[i].Amount;
            }
            $('#totalPayment').append(totalPayments);
        }).fail(function (error) {
            console.log(JSON.stringify(error));
        });

    // Wait 1000ms before we get the total values
    setTimeout(getTotals, 1000);
    
    // Get category list
    $.ajax({
        url: categoryUrl,
        method: "GET",
        headers: {
            "accept": "application/json;odata=verbose"
        },
        success: function (data) {
            var results = data.d.results;
            if (results.length > 0) {
                var item = '';

                for (var i = 0; i < results.length; i++) {
                    item += '<option value="' + results[i].Title + '">' + results[i].Title + '</option>';
                };
                
                $('#categories').append(item);
                $('#categories2').append(item);
            }

            $('select').material_select();
        },
        error: function (error) {
            console.log('Error: ' + error);
        }
    });

    $('#submitForm').click(function (e) {
        //Check for edit or new and call update or add function
        if ($('#myModalLabel').html() == 'New Income') {
            addIncome($('#nameField').val(), $('#amountField').val(), $('#descriptionField').val(), $('#dateField').val(), $('#categories option:selected').val());
        } else if ($('#myModalLabel').html() == 'New Payment') {
            addPayment($('#nameField').val(), $('#amountField').val(), $('#descriptionField').val(), $('#dateField').val(), $('#categories2 option:selected').val());
        }
    });

});

//Get totals from the status table - Uses with setTimeout()
function getTotals() {
    $('#balance').append($('#totalIncomster').text() - $('#totalPayment').text());
}

function getTotalIncomes(url) {
    return $.ajax({
        url: url,
        type: "GET",
        contentType: "application/json;odata=verbose",
        headers: {
            "Accept": "application/json;odata=verbose"
        }
    });
}

function getTotalPayment(url) {
    return $.ajax({
        url: url,
        type: "GET",
        contentType: "application/json;odata=verbose",
        headers: {
            "Accept": "application/json;odata=verbose"
        }
    });
}

function addNewItem() {
    $('#nameField').val('');
    $('#amountField').val('');
    $('#descriptionField').val('');
    $('#dateField').val('');
    $('#categories option:selected').val('');
    $('#categories2 option:selected').val('');
    $('#modalForm').modal('show');
};

//Add Income function
var addIncome = function (nameField, amountField, descriptionField, dateField, cateogries) {
    var requestUri = "../_api/web/lists/getbytitle('Incomsters')/items";

    var requestHeaders = {
        "Accept": "application/json;odata=verbose",
        "Content-Type": "application/json;odata=verbose",
        "X-RequestDigest": $('#__REQUESTDIGEST').val()
    }
    var fileData = {
        __metadata: { type: 'SP.Data.IncomstersListItem' },
        Title: nameField,
        Description: descriptionField,
        Date: dateField,
        Category: cateogries,
        Amount: amountField
        
    };
    var requestBody = JSON.stringify(fileData);

    return $.ajax({
        url: requestUri,
        type: "POST",
        headers: requestHeaders,
        data: requestBody
    });
};

//Add Payment function
var addPayment = function (nameField, amountField, descriptionField, dateField, cateogries) {
    var requestUri = "../_api/web/lists/getbytitle('Payments')/items";

    var requestHeaders = {
        "Accept": "application/json;odata=verbose",
        "Content-Type": "application/json;odata=verbose",
        "X-RequestDigest": $('#__REQUESTDIGEST').val()
    }
    var fileData = {
        __metadata: { type: 'SP.Data.PaymentsListItem' },
        Title: nameField,
        Description: descriptionField,
        Date: dateField,
        Category: cateogries,
        Amount: amountField

    };
    var requestBody = JSON.stringify(fileData);

    return $.ajax({
        url: requestUri,
        type: "POST",
        headers: requestHeaders,
        data: requestBody
    });
};

// Get both lists and show them in the modal
function getLists() {
    function getJsonDataAsync(url) {
        return $.ajax({
            url: url,
            method: "GET",
            contentType: "application/json",
            headers: {
                accept: "application/json;odata=verbose"
            }
        });
    }


    var requestURI1 = "../_api/lists/getbytitle('Incomsters')/items";
    var requestURI2 = "../_api/lists/getbytitle('Payments')/items";
    
    var req1 = getJsonDataAsync(requestURI1);
    var req2 = getJsonDataAsync(requestURI2);

    $.when(req1, req2).done(function (resp1, resp2) {
        var response1 = resp1[0].d.results;
        var response2 = resp2[0].d.results;
        var item1 = '';
        var item2 = '';

        for (var i = 0; i < response1.length; i++) {
            item1 += '<tr>';
            item1 += '<td>' + response1[i].Title + '</td>';
            item1 += '<td>' + moment(response1[i].Date).format('YYYY-MM-DD') + '</td>';
            item1 += '<td>' + response1[i].Category + '</td>';
            item1 += '<td>' + response1[i].Amount + '</td>';
            item1 += '</tr>';
        };
        $('#myMovementList tbody').append(item1);

        
        for (var i = 0; i < response2.length; i++) {
            item2 += '<tr>';
            item2 += '<td>' + response2[i].Title + '</td>';
            item2 += '<td>' + moment(response2[i].Date).format('YYYY-MM-DD') + '</td>';
            item2 += '<td>' + response2[i].Category + '</td>';
            item2 += '<td>' + response2[i].Amount + '</td>';
            item2 += '</tr>';
        };
        $('#myMovementList tbody').append(item2);
        
    });
};
        //Dates information
$.fn.dataTable.ext.search.push(
    function (settings, data, dataIndex) {
        var min = parseInt($('#min').val(), 5);
        var max = parseInt($('#max').val(), 5);
        var mount = parseFloat(data[3]) || 0; // use data for the age column

        if ((isNaN(min) && isNaN(max)) ||
            (isNaN(min) && mount <= max) ||
            (min <= mount && isNaN(max)) ||
            (min <= mount && mount <= max)) {
            return true;
        }
        return false;
    }
);

$(document).ready(function () {
    var table = $('#example').DataTable();

    // Event listener to the two range filtering inputs to redraw on input
    $('#min, #max').keyup(function () {
        table.draw();
    });
});

