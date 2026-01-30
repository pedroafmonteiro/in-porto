abstract class AgencyType {
  const AgencyType();
}

class StaticAgencyType extends AgencyType {
  final String url;
  const StaticAgencyType({required this.url});
}

class CkanAgencyType extends AgencyType {
  final String datasetId;
  const CkanAgencyType({required this.datasetId});
}
