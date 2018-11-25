using Braintree;
using System;
using System.Web.Script.Serialization;
public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BraintreeGateway gateway = new BraintreeGateway("ADD YOUR ACCESS TOKEN HERE");
        decimal amount = 0;
        try
        {
            amount = decimal.Parse(Request.Form["amount"]);
        }catch (Exception ex)
        {
            Response.Write("invalid ammount " + ex.ToString());
            return;
        }

        string paymentMethodNonce = Request.Form["payment_method_nonce"];
        var request = new TransactionRequest
        {
            Amount = amount,
            PaymentMethodNonce = paymentMethodNonce,
            Options = new TransactionOptionsRequest
            {
                SubmitForSettlement = true
            },
            DeviceData = Request.Form["device_data"],
            MerchantAccountId="USD",
        };

        Result<Transaction> result = gateway.Transaction.Sale(request);
        if (result.IsSuccess())
        {
            //The transaction is success do your acction and update the order after that redirect to receipt page
            Transaction transaction = result.Target;
            Response.Write("Success Transaction: " + transaction.Id);


            //Use to print the response in json format if needed
            //string json = new JavaScriptSerializer().Serialize(result);
            //Response.Write(json);
        }
        else if (result.Transaction != null)
        {
            string json = new JavaScriptSerializer().Serialize(result);
            Response.Write(json);
        }
        else
        {
            string errorMessages = "";
            foreach (ValidationError error in result.Errors.DeepAll())
            {
                errorMessages += "Error: " + (int)error.Code + " - " + error.Message + "\n";
            }
            Response.Write(errorMessages);
        }
    }
}