<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://js.braintreegateway.com/web/3.12.1/js/client.min.js"></script>
    <script src="https://js.braintreegateway.com/web/3.12.1/js/paypal.min.js"></script>
    <script src="https://js.braintreegateway.com/web/3.12.1/js/data-collector.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>

    <script>
        function guid() {
            function s4() {
                return Math.floor((1 + Math.random()) * 0x10000)
                    .toString(16)
                    .substring(1);
            }
            return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
                s4() + '-' + s4() + s4() + s4();
        }
    </script>

    <form action="Server" method="post" id="my-sample-form" autocomplete="off">
        <input type="hidden" name="payment_method_nonce" id="payment_method_nonce" value="fake-paypal-one-time-nonce">
        <!-- https://developers.braintreepayments.com/guides/paypal/vault/javascript/v3#collecting-device-data -->
        <input type="hidden" name="device_data" id="device_data" value="risk_correlation_id">
        <input type="hidden" name="amount" id="amount" value="11.99">
        <input type="hidden" name="invnum" id="invnum" value="myUniqueInvoice85201">
        <input type="hidden" name="custom" id="custom" value="myCustomTextInSTLReport">
        <input type="hidden" name="desc" id="desc" value="Decription for PayPal email receipt">
    </form>



    <script src="https://www.paypalobjects.com/api/button.js?"
        data-merchant="braintree"
        data-id="paypal-button"
        data-button="checkout"
        data-color="gold"
        data-size="medium"
        data-shape="pill"
        data-button_type="submit"
        data-button_disabled="false">
    </script>


    <script>
        // Fetch the button you are using to initiate the PayPal flow
        var paypalButton = document.querySelector('.paypal-button');
        var myForm = document.getElementById('my-sample-form');
        var uuid = guid();

        jQuery(document).ready(function () {
            $.get('Service.svc/GetTokenonly', {}, function (sData) {
                var clientToken = $.trim(sData.d);
                braintree.client.create({
                    authorization: clientToken
                }, function (clientErr, clientInstance) {
                    braintree.dataCollector.create({
                        client: clientInstance,
                        paypal: true
                    }, function (err, dataCollectorInstance) {
                        if (err) {
                            // Handle error
                            return;
                        }
                        // At this point, you should access the dataCollectorInstance.deviceData value and provide it
                        // to your server, e.g. by injecting it into your form as a hidden input.
                        myDeviceData = dataCollectorInstance.deviceData;
                    });
                    // Create PayPal component
                    braintree.paypal.create({
                        client: clientInstance
                    }, function (err, paypalInstance) {
                        paypalButton.addEventListener('click', function () {
                            // Tokenize here!
                            paypalInstance.tokenize({
                                flow: 'vault', // Required Set to 'checkout' for one-time payment flow, or 'vault' for Vault flow. 
                                billingAgreementDescription: 'One click payments at your.com', // visible to customers in their PayPal profile during Vault flows
                                intent: 'sale', // 'authorize' is default
                                offercredit: 'true', // Offers the customer PayPal Credit if they qualify. Checkout flows only.
                                useraction: 'commit', // changes buttton text to Pay Now
                                amount: document.getElementById('amount').value, // Required
                                currency: 'USD', // Required
                                locale: 'en_US',
                                landingPageType: 'billing', // defaults to login.
                                enableShippingAddress: true,
                                shippingAddressEditable: false,
                                shippingAddressOverride: {
                                    recipientName: 'Scruff McGruff',
                                    line1: '1234 Main St.',
                                    line2: 'Unit 1',
                                    city: 'Chicago',
                                    countryCode: 'US',
                                    postalCode: '60652',
                                    state: 'IL',
                                    phone: '123.456.7890'
                                }
                            }, function (err, tokenizationPayload) {
                                // Tokenization complete
                                // Send tokenizationPayload.nonce to server
                                document.getElementById('payment_method_nonce').value = tokenizationPayload.nonce;
                                // Send dataCollectorInstance.deviceData to server
                                document.getElementById('device_data').value = myDeviceData;
                                // Send invnum to server
                                document.getElementById('invnum').value = uuid;
                                alert(document.getElementById('device_data').value);
                                // alert(document.getElementById('payment_method_nonce').value);
                                myForm.submit();
                            });
                        });
                    });
                });
            });
        });

    </script>
</asp:Content>
