@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Provides info about the available flights'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity Z_I_FLIGHT_R_IGG
  as select from /dmo/flight
  association [1] to Z_I_CARRIER_IGG as _Airline on $projection.AirlineID = _Airline.AirlineID
{
      @UI.lineItem: [{ position: 10, label: 'Airline' }]
      @ObjectModel.text.association: '_Airline'
  key carrier_id     as AirlineID,
      @UI.lineItem: [{ position: 20, label: 'Connection Number' }]
  key connection_id  as ConnectionId,
      @UI.lineItem: [{ position: 30, label: 'Flight Date' }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
  key flight_date    as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.lineItem: [{ position: 40, label: 'Price' }]
      price          as Price,
      currency_code  as CurrencyCode,
      @UI.lineItem: [{ position: 50, label: 'Plane Type' }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      plane_type_id  as PlaneTypeId,
      @UI.lineItem: [{ position: 60, label: 'Maximum Seats' }]
      seats_max      as MaximumSeats,
      @UI.lineItem: [{ position: 70, label: 'Occupied Seats' }]
      seats_occupied as OccupiedSeats,
      
      /*Associations*/
      _Airline      
}
