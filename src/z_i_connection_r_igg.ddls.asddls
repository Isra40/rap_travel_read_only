@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Connection View - CDS Data Model'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true //*** exposes a standard search field on the UI
@UI.headerInfo.typeNamePlural: 'Connections'
@UI.headerInfo.typeName: 'Connection'
define view entity Z_I_CONNECTION_R_IGG
  as select from /dmo/connection as Connection
  association [1..*] to Z_I_FLIGHT_R_IGG as _Flight             on  $projection.AirlineID    = _Flight.AirlineID
                                                                and $projection.ConnectionID = _Flight.ConnectionId
  association [1]    to Z_I_CARRIER_IGG  as _Airline            on  $projection.AirlineID = _Airline.AirlineID
  association [1]    to Z_I_AIRPORT_IGG  as _DepartureAirport   on  $projection.DepartureAirport = _DepartureAirport.AirportId
  association [1]    to Z_I_AIRPORT_IGG  as _DestinationAirport on  $projection.DestinationAirport = _DestinationAirport.AirportId
{
      @UI.facet: [
      {
              id:       'Connection',
              purpose:  #STANDARD,
              type:     #IDENTIFICATION_REFERENCE,
              label:    'Connection',
              position: 10
      },
           {
              id:       'Flight',
              purpose:  #STANDARD,
              type:     #LINEITEM_REFERENCE,
              label:    'Flight',
              position: 20 ,
              targetElement: '_Flight'
      }]

      @UI.lineItem: [{ position: 10, label: 'Airline' }]
      @UI: {identification: [{ position: 10, label: 'Airline' }]}
      @EndUserText.quickInfo: 'Airline that operates the flight.'
      @ObjectModel.text.association: '_Airline'
      @Search.defaultSearchElement: true
  key Connection.carrier_id      as AirlineID,
      @UI.lineItem: [{ position: 20, label: 'Connection Number' }]
      @UI: {identification: [{ position: 20, label: 'Connection Number' }]}
  key Connection.connection_id   as ConnectionID,
      @UI.lineItem: [{ position: 30, label: 'Departure Airport Code' }]
      @UI.selectionField: [{ position: 10 }]
      @EndUserText.label: 'Departure Airport Code' //*** Use the same label as in lineItem
      @UI: {identification: [{ position: 30, label: 'Departure Airport Code'  }]}
      @ObjectModel.text.association: '_DepartureAirport'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'Z_I_AIRPORT_IGG',
                                                     element: 'AirportId'
                                                    }
                                         }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Connection.airport_from_id as DepartureAirport,
      @UI.lineItem: [{ position: 40, label: 'Destination Airport Code' }]
      @UI.selectionField: [{ position: 20 }]
      @EndUserText.label: 'Destination Airport Code' //*** Use the same label as in lineItem
      @UI: {identification: [{ position: 40, label: 'Destination Airport Code' }]}
      @ObjectModel.text.association: '_DestinationAirport'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'Z_I_AIRPORT_IGG',
                                                     element: 'AirportId'
                                                   }
                                         }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Connection.airport_to_id   as DestinationAirport,
      @UI.lineItem: [{ position: 50, label: 'Departure Time' }]
      @UI: {identification: [{ position: 50, label: 'Departure Time' }]}
      Connection.departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60, label: 'Arrival Time' }]
      @UI: {identification: [{ position: 60, label: 'Arrival Time' }]}
      Connection.arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      @UI: {identification: [{ position: 70, label: 'Distance' }]}
      Connection.distance        as Distance, //** secondary information, not to be displayed on list report entry page
      Connection.distance_unit   as DistanceUnit, //** secondary information, not to be displayed on list report entry page

      /*Associations*/
      @Search.defaultSearchElement: true
      _Flight,
      _Airline,
      _DepartureAirport,
      _DestinationAirport

}
