@istest
public class ManyWhoObjectUtils_Tests {

    private static testmethod void TestManyWhoFlowController() {
        // Create a dummy case to check against        
        Case c = new Case();
        c.Subject = 'Test';
        insert c;

        // Execute the call for a specific object
        SObject s_object = ManyWhoObjectUtils.getFullSObjectRecord('Case', c.ID);        
        List<ManyWhoAPI.ObjectAPI> m_object = ManyWhoObjectUtils.createMObject(s_object);

        // Execute the call for all objects
        List<SObject> s_objects = ManyWhoObjectUtils.getSObjectRecords(ManyWhoObjectUtils.getSelectAll('Case'));
        List<ManyWhoAPI.ObjectAPI> m_objects = ManyWhoObjectUtils.createMList(s_objects);

        // Execute the call for all objects with input List
        s_objects = ManyWhoObjectUtils.getFullSObjectRecords('Case', new List<Id>{c.Id});
        m_objects = ManyWhoObjectUtils.createMList(s_objects);

        // Execute the call for all objects with a where clause
        s_objects = ManyWhoObjectUtils.getFullSObjectRecords('Case', ' WHERE Id IN (\'' + c.Id + '\')');
        m_objects = ManyWhoObjectUtils.createMList(s_objects);
    }

}