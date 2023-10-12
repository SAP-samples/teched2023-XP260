using { sap.capire.incidents as my } from '../db/schema';
using { API_BUSINESS_PARTNER as S4 } from './external/API_BUSINESS_PARTNER';

service ProcessorService { 
  entity Incidents as projection on my.Incidents;

  @readonly
  entity Customers as projection on my.Customers;
}

annotate ProcessorService.Incidents with @odata.draft.enabled; 
annotate ProcessorService with @(requires: 'support');
extend projection ProcessorService.Customers with {
  firstName || ' ' || lastName as name: String
}