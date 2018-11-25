using Braintree;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;


[ServiceContract(Namespace = "")]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
public class Service
{
    [OperationContract]
    [WebInvoke(Method = "GET",
     ResponseFormat = WebMessageFormat.Json)]
    string GetTokenonly()
    {
        BraintreeGateway gateway = new BraintreeGateway("ADD YOUR ACCESS TOKEN HERE");
        string token = gateway.ClientToken.Generate();
        return token;
    }


}
