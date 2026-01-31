import '../model/app_agency.dart';
import '../model/agency_type.dart';

class AgencyRegistry {
  static const List<AppAgency> agencies = [
    AppAgency(
      id: 'metrodoporto',
      name: 'Metro do Porto',
      type: CkanAgencyType(datasetId: '15f22603-a216-492a-ab1c-40b1d8aa2f08'),
    ),
    /* AppAgency(
      id: 'stcp',
      name: 'STCP',
      type: CkanAgencyType(datasetId: '5275c986-592c-43f5-8f87-aabbd4e4f3a4'),
    ),
    AppAgency(
      id: 'cp',
      name: 'CP',
      type: StaticAgencyType(url: 'http://publico.cp.pt/gtfs/gtfs.zip'),
    ), */
  ];

  static AppAgency? getAgencyByName(String name) {
    try {
      return agencies.firstWhere((a) => a.name == name);
    } catch (_) {
      return null;
    }
  }

  static AppAgency? getAgencyById(String id) {
    try {
      return agencies.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}
