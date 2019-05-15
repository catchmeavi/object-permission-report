/**
* @author Avijit C
** Date : 05-14-2019
**/
public class reportPermissionController {
    public List<ObjectPermissions> permissions {get;set;}
    public Map<String,List<permissionWrapper>> outputWrapMap {get;set;}{outputWrapMap = new Map<String,List<permissionWrapper>>(); }
    public Map<String,String> objNameMap = new Map<String,String>();
    public reportPermissionController(){
        permissions = [SELECT Parent.Profile.Name, SobjectType, PermissionsCreate, PermissionsRead, PermissionsEdit, 
                       PermissionsDelete, PermissionsViewAllRecords, PermissionsModifyAllRecords 
                       FROM ObjectPermissions where Parent.Profile.Name <> NULL ]; 
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();             
        for(Schema.SObjectType f : gd){
            objNamemap.put(f.getDescribe().getName(),f.getDescribe().getLabel());
        }
        for(ObjectPermissions op : permissions ){
            if(outputWrapMap.get(op.Parent.Profile.Name) == NULL){
                List<permissionWrapper> permissionWrapList = new List<permissionWrapper>();
                permissionWrapList.add(new permissionWrapper(op,objNameMap));
                outputWrapMap.put(op.Parent.Profile.Name,permissionWrapList);
            }
            else{
                List<permissionWrapper> permissionWrapList = outputWrapMap.get(op.Parent.Profile.Name);
                permissionWrapList.add(new permissionWrapper(op,objNameMap));
                outputWrapMap.put(op.Parent.Profile.Name,permissionWrapList);
            }
        }
        
    }
    public class permissionWrapper{
        
        public String profileName {get;set;}
        public String objectName {get;set;}
        public Boolean permissionsCreate {get;set;}
        public Boolean permissionsRead {get;set;}  
        public Boolean permissionsEdit {get;set;}
        public Boolean permissionsDelete {get;set;}  
        public Boolean permissionsViewAllRecords {get;set;}  
        public Boolean permissionsModifyAllRecords {get;set;}   
        
        public permissionWrapper(ObjectPermissions permission,Map<String,String> objNameMap) {
            this.profileName = permission.Parent.Profile.Name;
            this.objectName = objNamemap.get(permission.SobjectType);
            this.permissionsCreate = permission.PermissionsCreate; 
            this.permissionsRead = permission.PermissionsRead;
            this.permissionsEdit = permission.PermissionsEdit;
            this.permissionsDelete = permission.PermissionsDelete;
            this.permissionsViewAllRecords = permission.PermissionsViewAllRecords;
            this.permissionsModifyAllRecords = permission.PermissionsModifyAllRecords;
        }
    }
    
}
