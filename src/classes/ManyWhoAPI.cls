global class ManyWhoAPI
{
    public static final String CONTENT_TYPE_DATETIME = 'ContentDateTime';
    public static final String CONTENT_TYPE_NUMBER = 'ContentNumber';
    public static final String CONTENT_TYPE_OBJECT = 'ContentObject';
    public static final String CONTENT_TYPE_PASSWORD = 'ContentPassword';
    public static final String CONTENT_TYPE_STRING = 'ContentString';
    public static final String CONTENT_TYPE_LIST = 'ContentList';
    public static final String CONTENT_TYPE_BOOLEAN = 'ContentBoolean';
    public static final String CONTENT_TYPE_CONTENT = 'ContentContent';

    public static final String INVOKE_TYPE_FORWARD = 'FORWARD';
    public static final String INVOKE_TYPE_DONE = 'DONE';
    public static final String INVOKE_TYPE_JOIN = 'JOIN';
    public static final String INVOKE_TYPE_WAIT = 'WAIT';
    public static final String INVOKE_TYPE_STATUS = 'STATUS';
    public static final String INVOKE_TYPE_SUCCESS = 'SUCCESS';
    public static final String INVOKE_TYPE_TOKEN_COMPLETED = 'TOKEN_COMPLETED';
    public static final String INVOKE_TYPE_SYNC = 'SYNC';
    public static final String INVOKE_TYPE_NAVIGATE = 'NAVIGATE';
    public static final String INVOKE_TYPE_WAITING_ON_VOTES = 'WAITING_ON_VOTES';
    
    public static String getContentValue(List<EngineValueAPI> engineValues, String developerName, Boolean isRequired)
    {
        String contentValue = null;
        
        if (engineValues != null)
        {
            for (EngineValueAPI engineValue : engineValues)
            {
                if (engineValue.developerName.equalsIgnoreCase(developerName) == true)
                {
                    contentValue = engineValue.contentValue;
                    break;
                }
            }

        }
        
        return contentValue;
    }
    
    public class DescribeServiceResponseAPI
    {
        public CultureAPI culture;
        public String uri;
        public List<DescribeValueAPI> configurationValues;
        public Boolean providesLogic = false;
        public Boolean providesViews = false;
        public Boolean providesDatabase = false;
        public Boolean providesIdentity = false;
        public Boolean providesSocial = false;
        public Boolean providesFiles = false;
        public List<DescribeServiceActionResponseAPI> actions;
        public DescribeServiceInstallResponseAPI install;
    }
    
    public class DescribeServiceInstallResponseAPI
    {
        public List<TypeElementRequestAPI> typeElements;
    }
    
    public class DescribeValueAPI
    {
        public DescribeValueAPI(String developerName, String contentType, Boolean isRequired) {
            this.developerName = developerName;
            this.contentType = contentType;
            this.isRequired = isRequired;
        }

        public DescribeValueAPI(String developerName, String contentType, String typeElementDeveloperName, Boolean isRequired) {
            this.developerName = developerName;
            this.contentType = contentType;
            this.typeElementDeveloperName = typeElementDeveloperName;
            this.isRequired = isRequired;
        }
    
        public String developerName;
        public String contentValue;
        public Boolean isRequired = false;
        public String contentType;
        public String typeElementDeveloperName;
        public Integer ordinal = 0;
    }
    
    public class DescribeServiceActionResponseAPI
    {
        public String uriPart;
        public String developerName;
        public String developerSummary;
        public List<DescribeUIServiceActionOutcomeAPI> serviceActionOutcomes;
        public List<DescribeValueAPI> serviceInputs;
        public List<DescribeValueAPI> serviceOutputs;
        public Boolean isViewMessageAction = false;
    }
    
    public class DescribeUIServiceActionOutcomeAPI
    {
        public String id;
        public String developerName;
        public String developerSummary;
    }

    public class CultureAPI
    {
        public String id;
        public String developerName;
        public String developerSummary;
        public String brand;
        public String language;
        public String country;
        public String variant;
    }
    
    public class EngineValueAPI
    {
        public EngineValueAPI(String developerName, String contentType, String contentValue) {
            this.developerName = developerName;
            this.contentType = contentType;
            this.contentValue = contentValue;
        }

        public EngineValueAPI(String developerName, String contentType, ManyWhoAPI.ObjectAPI objectData) {
            this.developerName = developerName;
            this.contentType = contentType;
            
            if (objectData != null) {
                this.objectData = new List<ManyWhoAPI.ObjectAPI>();
                this.objectData.Add(objectData);
            }
        }

        public EngineValueAPI(String developerName, String contentType, List<ManyWhoAPI.ObjectAPI> objectData) {
            this.developerName = developerName;
            this.contentType = contentType;
            this.objectData = objectData;
        }

        public String valueElementId;
        public String typeElementId;
        public String typeElementPropertyId;
        public String developerName;
        public String typeElementDeveloperName;
        public String typeElementPropertyDeveloperName;
        public String contentValue;
        public String contentType;
        public List<ObjectAPI> objectData;
    }

    public class ObjectAPI
    {
        public ObjectAPI(String externalId, String developerName) {
            this.externalId = externalId;
            this.developerName = developerName;
            this.properties = new List<PropertyAPI>();
        }

        public String internalId;
        public String externalId;
        public String developerName;
        public String typeElementId;
        public Integer order = 0;
        public List<PropertyAPI> properties;
        public Boolean isSelected = true;
    }
    
    public class PropertyAPI
    {
        public PropertyAPI(String developerName, String contentValue) {
            this.developerName = developerName;
            this.contentValue = contentValue;
        }

        public PropertyAPI(String developerName, ManyWhoAPI.ObjectAPI objectData) {
            this.developerName = developerName;
            
            if (objectData != null) {
                this.objectData = new List<ManyWhoAPI.ObjectAPI>();
                this.objectData.Add(objectData);
            }
        }

        public PropertyAPI(String developerName, List<ManyWhoAPI.ObjectAPI> objectData) {
            this.developerName = developerName;
            this.objectData = objectData;
        }

        public String typeElementPropertyId;
        public String developerName;
        public String contentValue;
        public List<ObjectAPI> objectData;
    }

    public virtual class BaseRequestAPI
    {
        public String token;
        public String tenantId;
        public String callbackUri;
        public CultureAPI culture;
        public List<EngineValueAPI> configurationValues;
        public GroupAuthorizationAPI authorization;
        public Map<String, String> annotations;
        public Map<String, String> attributes;
    }

    public class ServiceRequestAPI extends BaseRequestAPI
    {
        public String joinPlayerUri;
        public String playerUri;
        public String uri;
        public List<EngineValueAPI> inputs;
        //public List<OutcomeAvailableAPI> outcomes;
    }

    public virtual class BaseResponseAPI
    {
        public String token;
        public String tenantId;
        public CultureAPI culture;
        public Map<String, String> annotations;
    }

    public class ServiceResponseAPI extends BaseResponseAPI
    {
        public String invokeType;
        public String waitMessage;
        public List<EngineValueAPI> outputs;
        public String selectedOutcomeId;
        public Map<String, String> rootFaults;
        public List<ValueFaultAPI> valueFaults;
        public String mode;
    }
    
    public class GroupAuthorizationAPI
    {
        public String serviceElementId;
        public String globalAuthenticationType;
        public String streamBehaviourType;
        public List<GroupAuthorizationGroupAPI> groups;
        public List<GroupAuthorizationUserAPI> users;
        public List<GroupAuthorizationLocationAPI> locations;
    }
    
    public class GroupAuthorizationLocationAPI
    {
        public String developerName;
        public String developerSummary;
        public String attribute;
    }

    public class GroupAuthorizationGroupAPI
    {
        public String authenticationId;
        public String attribute;
    }
    
    public class GroupAuthorizationUserAPI
    {
        public String authenticationId;
        public String attribute;
        public Boolean runningUser = false;
    }
    
    public class ValueFaultAPI
    {
        public String valueElementToReferenceId;
        public String valueElementTypeElementPropertyToReferenceId;
        public String faultCode;
        public String faultMessage;
    }

    public class StateAPI
    {
        public String id;
        public String parentId;
        public DateTime dateCreated;
        public DateTime dateModified;
        public FlowIdAPI currentFlowId;
        public String currentFlowDeveloperName;
        public String currentMapElementId;
        public String currentMapElementDeveloperName;
        public String currentStreamId;
        public String currentRunningUserId;
        public string currentRunningUserEmail;
        public String externalIdentifier;
        public String manywhoTenantId;
        //public Map<String, String> annotations;
        public List<StateEntryAPI> stateEntries;
        public StateEntryAPI precommitStateEntry;
        public List<StateValueAPI> values;
        public String authorizationHeader;
        public Boolean isDone = false;
        //public LogAPI log;
    }

    public class GeoLocationAPI
    {
        public Decimal latitude = 0;
        public Decimal longitude = 0;
        public Decimal accuracy = 0;
        public Decimal altitude = 0;
        public Decimal altitudeAccuracy = 0;
        public Decimal heading = 0;
        public Decimal speed = 0;
        public Datetime locationTime;
    }

    public class StateEntryAPI
    {
        public String id;
        //public FlowIdAPI flowId;
        public String flowDeveloperName;
        public String mapElementId;
        public String mapElementDeveloperName;
        public Datetime dateCommitted;
        //public List<StateValueAPI> values;
        //public List<UserInteractionAPI> userInteractions;
    }

    public class StateLogAPI
    {
        public List<StateLogEntryAPI> stateLogEntries;
    }

    public class StateLogEntryInvokePairAPI
    {
        public EngineInvokeRequestAPI engineInvokeRequest;
        public EngineInvokeResponseAPI engineInvokeResponse;
        public String order;
    }

    public class StateLogEntryAPI
    {
        public EngineInvokeRequestAPI engineInvokeRequest;
        public EngineInvokeResponseAPI engineInvokeResponse;
        public List<StateLogEntryInvokePairAPI> stateLogEntryInvokePairs;
        public String timeStamp;
        public String isActive;
    }
    
    public class StateValueAPI
    {
        public String valueElementId;
        public String valueElementDeveloperName;
        public List<ObjectAPI> objectData;
        public String contentValue;
        public String contentType;
    }

    public class UserInteractionAPI
    {
        public String manywhoUserId;
        public Decimal latitude = 0;
        public Decimal longitude = 0;
        public Decimal accuracy = 0;
        public Decimal altitude = 0;
        public Decimal altitudeAccuracy = 0;
        public Decimal heading = 0;
        public Decimal speed = 0;
        public Datetime locationTime;
    }

    public class UserVoteAPI
    {
        public String selectedOutcomeId;
        public String directoryUserId;
        public String manywhoUserId;
        public Decimal latitude = 0;
        public Decimal longitude = 0;
        public Decimal accuracy = 0;
        public Decimal altitude = 0;
        public Decimal altitudeAccuracy = 0;
        public Decimal heading = 0;
        public Decimal speed = 0;
        public Datetime locationTime;
    }

    public class EngineInvokeRequestAPI
    {
        public CultureAPI culture;
        public String stateId;
        public String stateToken;
        public String currentMapElementId;
        public String navigationElementId;
        public String selectedNavigationItemId;
        public String selectedMapElementId;
        public String invokeType;
        public Map<String, String> annotations;
        public GeoLocationAPI geoLocation;
        //public MapElementInvokeRequestAPI mapElementInvokeRequest;
        public String mode;
    }

    public class EngineInvokeResponseAPI
    {
        public CultureAPI culture;
        public String stateId;
        public String parentStateId;
        public String stateToken;
        public String alertEmail;
        public String waitMessage;
        public String notAuthorizedMessage;
        public String currentMapElementId;
        public String currentStreamId;
        public String invokeType;
        public Map<String, String> annotations;
        //public List<MapElementInvokeResponseAPI> mapElementInvokeResponses;
        //public VoteResponseAPI voteResponse;
        public StateLogAPI stateLog;
        public List<EngineValueAPI> preCommitStateValues;
        public List<EngineValueAPI> stateValues;
        public List<EngineValueAPI> outputs;
        public String statusCode;
        public String runFlowUri;
        public String joinFlowUri;
        //public EngineAuthorizationContextAPI authorizationContext;
        //public List<NavigationElementReferenceAPI> navigationElementReferences;
    }
    
    public class FlowIdAPI
    {
        public String id;
        public String versionId;
    }
    
    public class LogAPI
    {
        public String id;
        public String elementType;
        public String developerName;
        public String developerSummary;
        public String stateId;
        public String flowId;
        public String flowDeveloperName;
        public Map<string, LogEntryAPI> entries;
    }
    
    public class LogEntryAPI
    {
        public String id;
        public String elementType;
        public String developerName;
        public String developerSummary;
        public Datetime timestamp;
        public String message;
        public String data;
        public String level;
    }
    
    public class WhoAPI 
    {
        public String id;
        public String firstName;
        public String lastName;
        public String email;
    }
    
    public class FlowResponseAPI 
    {
        public Datetime dateCreated;
        public Datetime dateModified;
        public WhoAPI whoCreated;
        public WhoAPI whoModified;
        public WhoAPI whoOwner;
        public String alertEmail;
        public Boolean isActive = false;
        public Boolean isDefault = false;
        public String comment;
        public String editingToken;
        public FlowIdAPI id;
        public String developerName;
        public String developerSummary;
        public String startMapElementId;
        public Boolean allowJumping = false;
        public Decimal stateExpirationLength = 0;
        public GroupAuthorizationAPI authorization;
    }
    
    public class TypeElementRequestAPI
    {
        public TypeElementRequestAPI(String developerName, String developerSummary) {
            this.developerName = developerName;
            this.developerSummary = developerSummary;
            this.elementType = 'TYPE';
            this.properties = new List<TypeElementPropertyAPI>();
        }

        public String id;
        public String elementType;
        public String developerName;
        public String developerSummary;
        public String serviceElementId;
        public List<TypeElementPropertyAPI> properties;
        public List<TypeElementBindingAPI> bindings;
        public Boolean updateByName = false;
    }

    public class TypeElementPropertyAPI
    {
        public TypeElementPropertyAPI(String developerName, String contentType) {
            this.developerName = developerName;
            this.contentType = contentType;
        }
        
        public String id;
        public String developerName;
        public String contentType;
        public String contentFormat;
        public String typeElementId;
        public String typeElementDeveloperName;
    }

    public class TypeElementBindingAPI
    {
        public String id;
        public String developerName;
        public String developerSummary;
        public String databaseTableName;
        public String serviceElementId;
        public List<TypeElementPropertyBindingAPI> propertyBindings;
    }

    public class TypeElementPropertyBindingAPI
    {
        public TypeElementPropertyBindingAPI(String databaseFieldName, String typeElementPropertyDeveloperName, String databaseContentType) {
            this.databaseFieldName = databaseFieldName;
            this.typeElementPropertyDeveloperName = typeElementPropertyDeveloperName;
            this.databaseContentType = databaseContentType;
        }

        public String databaseFieldName;
        public String typeElementPropertyId;
        public String typeElementPropertyDeveloperName;
        public String databaseContentType;
    }
}