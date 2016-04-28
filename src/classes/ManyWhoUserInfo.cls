public class ManyWhoUserInfo {
    public ManyWhoUserInfo(String sessionId, String sessionUrl, String userId) {
        this.sessionId = sessionId;
        this.sessionUrl = sessionUrl;
        this.userId = userId;
    }
    
    @AuraEnabled
    public String sessionId { get; set; }
    
    @AuraEnabled
    public String sessionUrl { get; set; }
    
    @AuraEnabled
    public String userId { get; set; }
}