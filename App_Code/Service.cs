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
        BraintreeGateway gateway = new BraintreeGateway("access_token$sandbox$4hymnjxcjfbp5w7w$501a3438a3e47909e49f6c8ba0e92176");
        string token = gateway.ClientToken.Generate();
        return token;
    }


}
