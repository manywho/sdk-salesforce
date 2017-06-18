public class ManyWhoObjectUtils
{
    static final String DATE_TYPE = 'DATE';
    static final String DATETIME_TYPE = 'DATETIME';
    
    public static SObject getFullSObjectRecord(String objectName, String objectID) {

        return Database.query(getSelectById(objectName, objectID));

    }

    public static List<SObject> getFullSObjectRecords(String objectName, List<String> objectIDs) {

        return Database.query(getSelectByIds(objectName, objectIDs));

    }

    public static List<SObject> getFullSObjectRecords(String objectName, String whereClause) {

        system.debug('soql: ' + getSelectByIds(objectName, whereClause));

        return Database.query(getSelectByIds(objectName, whereClause));

    }

    public static List<SObject> getSObjectRecords(String soql) {

        return Database.query(soql);

    }
    
    public static String getSelectById(String objectName, String objectID) {

        String soql = getSelectAll(objectName);
        
        soql += ' WHERE Id = \'' + objectID + '\'';

        return soql;

    }

    public static String getSelectByIds(String objectName, List<String> objectIDs) {

        String soql = getSelectAll(objectName);
        
        soql += ' WHERE Id IN (\'' + String.join(objectIDs, '\',\'') + '\')';

        return soql;

    }

    public static String getSelectByIds(String objectName, String whereClause) {

        String soql = getSelectAll(objectName);
        
        soql += whereClause;

        return soql;

    }

    public static String getSelectAll(String objectName) {

        Map<String, Schema.SObjectField> fieldMap = getFieldMap(objectName);
        String soql = 'SELECT ';

        if (fieldMap != null) {

            for (Schema.SObjectField sfield : fieldMap.Values()) {
    
                Schema.DescribeFieldResult dfield = sfield.getDescribe();
                
                soql = soql + dfield.getName() + ', ';

            }
            
            soql = soql.substring(0, soql.length() - 2);

        }

        soql += ' FROM ' + objectName;
        
        return soql;
    }

    public static List<ManyWhoAPI.ObjectAPI> createMList(List<SObject> s_objects) {
    
        List<ManyWhoAPI.ObjectAPI> m_objects = null;

        if (s_objects != null &&
            s_objects.size() > 0) {
            
            m_objects = new List<ManyWhoAPI.ObjectAPI>();
            Map<String, Schema.SObjectField> fieldMap = getFieldMap(s_objects[0]);
            
            for (SObject s_object : s_objects) {

                m_objects.Add(buildMObject(fieldMap, s_object));
            }
        }
        
        return m_objects;
    }

    public static List<ManyWhoAPI.ObjectAPI> createMObject(SObject s_object) {

        Map<String, Schema.SObjectField> fieldMap = null;
        List<ManyWhoAPI.ObjectAPI> m_objects = null;
        ManyWhoAPI.ObjectAPI m_object = null;

        fieldMap = getFieldMap(s_object);
        m_object = buildMObject(fieldMap, s_object);
        
        if (m_object != null) {
            m_objects = new List<ManyWhoAPI.ObjectAPI>();
            m_objects.Add(m_object);
        }
        
        return m_objects;
    }
    
    public static ManyWhoAPI.TypeElementRequestAPI createMType(SObject s_object) {
        
        Map<String, Schema.SObjectField> fieldMap = null;
        List<ManyWhoAPI.ObjectAPI> m_objects = null;
        ManyWhoAPI.TypeElementRequestAPI m_type = null;

        fieldMap = getFieldMap(s_object);
        
        return buildMType(fieldMap, s_object);
    }
    
    private static ManyWhoAPI.ObjectAPI buildMObject(Map<String, Schema.SObjectField> fieldMap, SObject s_object) {

        ManyWhoAPI.ObjectAPI m_object = null;

        if (fieldMap != null &&
            s_object != null) {
            
            m_object = new ManyWhoAPI.ObjectAPI(s_object.ID, getSObjectLabel(s_object));            
            
            for (Schema.SObjectField sfield : fieldMap.Values()) {

                Schema.DescribeFieldResult dfield = sfield.getDescribe();
                ManyWhoAPI.PropertyAPI property = null;
                String value = String.valueOf(s_object.get(dfield.getName()));

                if(dfield.getType().name() == DATE_TYPE) {

                    Date d = Date.valueOf(s_object.get(dfield.getName()));
                    if(value != null)
                        value = value.replace(' 00:00:00', '');

                } else if(dfield.getType().name() == DATETIME_TYPE) {

                    DateTime dt = DateTime.valueOf(s_object.get(dfield.getName()));
                    if(dt != null)
                        value = dt.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');

                }

                property = new ManyWhoAPI.PropertyAPI(dfield.getLabel(), value);
                
                m_object.properties.Add(property);

            }

        }

        return m_object;
    }

    private static ManyWhoAPI.TypeElementRequestAPI buildMType(Map<String, Schema.SObjectField> fieldMap, SObject s_object) {

        ManyWhoAPI.TypeElementRequestAPI m_type = null;
        ManyWhoAPI.TypeElementBindingAPI m_typeBinding = null;

        if (fieldMap != null &&
            s_object != null) {
                
            String objectName = getSObjectName(s_object);

            // Create the binding for the Type            
            m_typeBinding = new ManyWhoAPI.TypeElementBindingAPI();
            m_typeBinding.developerName = 'Salesforce ' + objectName;
            m_typeBinding.developerSummary = 'The binding for ' + objectName;
            m_typeBinding.databaseTableName = objectName;
            m_typeBinding.propertyBindings = new List<ManyWhoAPI.TypeElementPropertyBindingAPI>();
            
            // Create the root Type
            m_type = new ManyWhoAPI.TypeElementRequestAPI(getSObjectLabel(s_object), null);            
            m_type.bindings = new List<ManyWhoAPI.TypeElementBindingAPI>();
            m_type.bindings.Add(m_typeBinding);
                        
            for (Schema.SObjectField sfield : fieldMap.Values()) {

                Schema.DescribeFieldResult dfield = sfield.getDescribe();
                ManyWhoAPI.TypeElementPropertyAPI property = null;
                ManyWhoAPI.TypeElementPropertyBindingAPI propertyBinding = null;

                // Create the root property
                property = new ManyWhoAPI.TypeElementPropertyAPI(dfield.getLabel(), getContentTypeForDisplayType(String.valueOf(dfield.getType())));

                // Create the data binding
                propertyBinding = new ManyWhoAPI.TypeElementPropertyBindingAPI(dfield.getName(), dfield.getLabel(), String.valueOf(dfield.getType()));
                
                m_type.properties.Add(property);
                m_typeBinding.propertyBindings.Add(propertyBinding);
            }
        }

        return m_type;
    }
    
    private static Map<String, Schema.SObjectField> getFieldMap(SObject s_object) {
        
        return getFieldMap(getSObjectName(s_object));
    }
        
    private static Map<String, Schema.SObjectField> getFieldMap(String objectName) {
    
        Map<String, Schema.SObjectType> schemaMap = null;
        Map<String, Schema.SObjectField> fieldMap = null;

        if (String.isNotBlank(objectName)) {

            schemaMap = Schema.getGlobalDescribe();
            fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
        }
    
        return fieldMap;
    }

    private static String getSObjectLabel(SObject s_object) {

        String label = null;
        
        if (s_object != null) {
            label = s_object.getSObjectType().getDescribe().getLabel();
        }
        
        return label;
    }

    private static String getSObjectName(SObject s_object) {

        String name = null;
        
        if (s_object != null) {
            name = s_object.getSObjectType().getDescribe().getName();
        }
        
        return name;
    }
    
    private static String getContentTypeForDisplayType(String displayType) {
        
        String contentType = null;

        displayType = displayType.toLowerCase();

        if ('string' == displayType ||
            'id' == displayType ||
            'reference' == displayType ||
            'textarea' == displayType ||
            'phone' == displayType ||
            'url' == displayType ||
            'email' == displayType ||
            'combobox' == displayType ||
            'picklist' == displayType ||
            'multipicklist' == displayType ||
            'base64' == displayType ||
            'anytype' == displayType) {
            contentType = ManyWhoAPI.CONTENT_TYPE_STRING;
        }
        else if ('int' == displayType ||
                 'double' == displayType ||
                 'currency' == displayType ||
                 'percent' == displayType) {
            contentType = ManyWhoAPI.CONTENT_TYPE_NUMBER;
        }
        else if ('date' == displayType ||
                 'datetime' == displayType ||
                 'time' == displayType) {
            contentType = ManyWhoAPI.CONTENT_TYPE_DATETIME;
        }
        else if ('boolean' == displayType) {
            contentType = ManyWhoAPI.CONTENT_TYPE_BOOLEAN;
        }
        else
        {
            // Anything else is a string to ManyWho
            contentType = ManyWhoAPI.CONTENT_TYPE_STRING;
        }

        return contentType;
    }
}