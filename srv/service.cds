using common.db.CommonEntities as CommonObj from '../db/schema/Common';
using masterData as MD from '../db/schema/masterData';
using FDC as FDC from '../db/schema/FDC';


/*Refer https://github.com/SAP-samples/hana-opensap-cloud-2020/blob/main/db/schema/purchaseOrder.cds */

service MasterDataService @(path : '/MasterDataService')
{
 entity Mediums as projection on CommonObj.Medium;
 entity Dimensions as projection on CommonObj.Dimension;
 entity Measurements  as projection on CommonObj.Measurement;
 entity NetworkObjectTypes as projection on CommonObj.NetworkObjectTypes;

 view ProductionNetworks as select from MD.ProductionNetworks;
 view ProductionNetworksVH  @(cds.redirection.target:false) as select from MD.ProductionNetworksVH;

 entity NetworkObjects as projection on MD.NetworkObjects;


 
}


service FDCService  @(path : '/FDC')
{
    entity WCTests as projection on FDC.WellCompletionTests {
      *, items : redirected to WCTestsItems
    };
    entity WCTestsItems as projection on FDC.WCTestsItems {
   * , parent : redirected to WCTests, measurementProperty : redirected to Measurements
    };
   entity Measurements  as projection on CommonObj.Measurement;

   view Worklist as select from FDC.WCTestWorklist;
   

}


