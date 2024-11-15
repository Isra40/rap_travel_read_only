@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Provides information about the involved airports.'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_I_AIRPORT_IGG
  as select from /dmo/airport as Airport
{
  key Airport.airport_id as AirportId,
      @Semantics.text: true
      Airport.name       as Name,
      Airport.city       as City,
      Airport.country    as CountryCode
}
