@istest
public class ManyWhoHttp_Tests {

    private static testmethod void TestManyWhoHttp() {

        Test.setMock(HttpCalloutMock.class, new ManyWhoHttpMock('Case: Example Flow', 'My example Flow to test.'));

        ManyWhoHttp.getRunFlows('abcd', null, false);
        ManyWhoHttp.getRunFlows('abcd', 'efgh', false);
        ManyWhoHttp.getRunFlows('abcd', 'efgh', true);
    
    }

}