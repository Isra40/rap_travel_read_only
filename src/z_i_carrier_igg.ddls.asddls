@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Provides info about airlines that operate the flights.'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity Z_I_CARRIER_IGG
  as select from /dmo/carrier as Airline
{
  key Airline.carrier_id    as AirlineID,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Airline.name          as Name,
      Airline.currency_code as CurrencyCode
}
