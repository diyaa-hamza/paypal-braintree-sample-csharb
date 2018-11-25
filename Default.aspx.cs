using Braintree;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //BraintreeGateway gateway = new BraintreeGateway("access_token$sandbox$pfpywzwnhj6dtcqk$17ba4ac272f09bc4e76c76aee1582c8c");
        //string token = gateway.ClientToken.Generate();
        ////Response.Write("Your token is: " + token);

        //decimal amount = 10;
        //var request = new TransactionRequest
        //{
        //    Amount = amount,
        //    PaymentMethodNonce = "fake-paypal-one-time-nonce",
        //    Options = new TransactionOptionsRequest
        //    {
        //        SubmitForSettlement = true
        //    }
        //};

        //Result<Transaction> result = gateway.Transaction.Sale(request);
        //if (result.IsSuccess())
        //{
        //    Transaction transaction = result.Target;
        //    Response.Write("Success Transaction: " + transaction.Id);
        //}
        //else if (result.Transaction != null)
        //{
        //    Response.Write(result.Message);
        //    Response.Write("Show: " +  result.Transaction.Id);
        //}
        //else
        //{
        //    string errorMessages = "";
        //    foreach (ValidationError error in result.Errors.DeepAll())
        //    {
        //        errorMessages += "Error: " + (int)error.Code + " - " + error.Message + "\n";
        //    }
        //    Response.Write(errorMessages);
        //}


    }
}