@istest
public class ManyWhoAPI_Tests {

    private static testmethod void TestManyWhoAPI() {

        List<ManyWhoAPI.EngineValueAPI> engineValues = new List<ManyWhoAPI.EngineValueAPI>();
        engineValues.add(new ManyWhoAPI.EngineValueAPI('test', 'ContentString', 'abcd'));
        
        ManyWhoAPI.getContentValue(engineValues, 'test', true);

        ManyWhoAPI.DescribeServiceResponseAPI describeServiceResponse = new ManyWhoAPI.DescribeServiceResponseAPI();
        describeServiceResponse.providesLogic = true;
        describeServiceResponse.providesViews = true;
        describeServiceResponse.providesDatabase = true;
        describeServiceResponse.providesIdentity = true;
        describeServiceResponse.providesSocial = true;
        describeServiceResponse.providesFiles = true;
        
        ManyWhoAPI.DescribeValueAPI describeValue = new ManyWhoAPI.DescribeValueAPI('test', 'ContentString', true);
        describeValue.isRequired = true;
        describeValue.ordinal = 1;
        
        describeValue = new ManyWhoAPI.DescribeValueAPI('test', 'ContentObject', 'Test', true);
        describeValue.isRequired = true;
        describeValue.ordinal = 1;
        
        ManyWhoAPI.DescribeServiceActionResponseAPI describeServiceActionResponse = new ManyWhoAPI.DescribeServiceActionResponseAPI();
        describeServiceActionResponse.isViewMessageAction = true;
        
        ManyWhoAPI.ObjectAPI mobject = new ManyWhoAPI.ObjectAPI('123', 'Test');
        mobject.order = 1;
        mobject.isSelected = true;
        
        ManyWhoAPI.PropertyAPI property = new ManyWhoAPI.PropertyAPI('Test', 'ContentString');
        property = new ManyWhoAPI.PropertyAPI('Test', mobject);
        
        List<ManyWhoAPI.ObjectAPI> objectDatas = new List<ManyWhoAPI.ObjectAPI>();
        objectDatas.Add(mobject);
		property = new ManyWhoAPI.PropertyAPI('Test', objectDatas);
        
        ManyWhoAPI.GroupAuthorizationUserAPI groupAuthorizationUser = new ManyWhoAPI.GroupAuthorizationUserAPI();
        groupAuthorizationUser.runningUser = true;
        
        ManyWhoAPI.StateAPI state = new ManyWhoAPI.StateAPI();
        state.isDone = true;
        
        ManyWhoAPI.GeoLocationAPI geoLocation = new ManyWhoAPI.GeoLocationAPI();
        geoLocation.latitude = 1;
        geoLocation.longitude = 1;
        geoLocation.accuracy = 1;
        geoLocation.altitude = 1;
        geoLocation.altitudeAccuracy = 1;
        geoLocation.heading = 1;
        geoLocation.speed = 1;
        
        ManyWhoAPI.UserInteractionAPI userInteraction = new ManyWhoAPI.UserInteractionAPI();
        userInteraction.latitude = 1;
        userInteraction.longitude = 1;
        userInteraction.accuracy = 1;
        userInteraction.altitude = 1;
        userInteraction.altitudeAccuracy = 1;
        userInteraction.heading = 1;
        userInteraction.speed = 1;
        
        ManyWhoAPI.UserVoteAPI userVote = new ManyWhoAPI.UserVoteAPI();
        userVote.latitude = 1;
        userVote.longitude = 1;
        userVote.accuracy = 1;
        userVote.altitude = 1;
        userVote.altitudeAccuracy = 1;
        userVote.heading = 1;
        userVote.speed = 1;
        
        ManyWhoAPI.FlowResponseAPI flowResponse = new ManyWhoAPI.FlowResponseAPI();
        flowResponse.isActive = true;
        flowResponse.isDefault = true;
        flowResponse.allowJumping = true;
        flowResponse.stateExpirationLength = 1;
        
        ManyWhoAPI.TypeElementRequestAPI typeElementRequest = new ManyWhoAPI.TypeElementRequestAPI('Test', 'A Test Type');
        typeElementRequest.updateByName = true;
        
        ManyWhoAPI.TypeElementPropertyAPI typeElementProperty = new ManyWhoAPI.TypeElementPropertyAPI('Property', 'ContentString');

        ManyWhoAPI.TypeElementPropertyBindingAPI typeElementPropertyBinding = new ManyWhoAPI.TypeElementPropertyBindingAPI('Property__c', 'Property', 'string');        
    }

}