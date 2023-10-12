using { User, cuid, managed, sap.common.CodeList } from '@sap/cds/common';
namespace sap.capire.incidents;

/**
 * Incidents created by Customers.
*/
entity Incidents : cuid, managed {
  customer     : Association to Customers;
  title        : String  @title : 'Title';
  urgency      : Association to Urgency;
  status       : Association to Status; 
  conversations: Composition of many Conversations on conversations.incidents = $self;
}

/**
 * Customers entitled to create support Incidents.
*/
entity Customers : managed {
      key ID        : String;
      firstName     : String;
      lastName      : String;
      email         : EMailAddress;
      phone         : PhoneNumber;
      incidents     : Association to many Incidents on incidents.customer = $self;
}

entity Conversations : cuid, managed {
  incidents : Association to Incidents;
  timestamp : DateTime;
  author    : String @cds.on.insert: $user;
  message   : String;
}

entity Status : CodeList {
  key code: String enum {
      new = 'N';
      assigned = 'A'; 
      in_process = 'I'; 
      on_hold = 'H'; 
      resolved = 'R'; 
      closed = 'C'; 
  };
  criticality : Integer;
}

entity Urgency : CodeList {
  key code: String enum {
      high = 'H';
      medium = 'M'; 
      low = 'L'; 
  };
}

type EMailAddress : String;
type PhoneNumber : String;
type City : String;