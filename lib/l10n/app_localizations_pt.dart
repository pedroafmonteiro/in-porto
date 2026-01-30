// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'In Porto.';

  @override
  String get appDescription => 'Explore o Porto como nunca antes.';

  @override
  String get getStarted => 'Começar';

  @override
  String get downloadDataTitle => 'Transferir Dados';

  @override
  String get downloadDataText1 =>
      'Para usar esta aplicação, precisará de se ligar à internet pelo menos uma vez para transferir informações essenciais da nuvem.';

  @override
  String get downloadDataText2 =>
      'Todos os dados estão disponíveis publicamente e dizem respeito à cidade do Porto. Nenhuma informação privada ou análises que possam identificá-lo são recolhidas.';

  @override
  String get downloadDataText3 =>
      'Este processo pode demorar alguns minutos, dependendo da sua ligação à internet e da quantidade de dados a transferir.';

  @override
  String get downloadDataText4 =>
      'Não feche a aplicação nem desligue o seu dispositivo durante este processo.';

  @override
  String get continueText => 'Continuar';

  @override
  String get finishText => 'Terminar';

  @override
  String get connectivitySuccess => 'Ligado à internet.';

  @override
  String get connectivityError => 'Sem ligação à internet.';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get system => 'Sistema';

  @override
  String get appearanceTitle => 'Aparência';

  @override
  String get lightMode => 'Claro';

  @override
  String get darkMode => 'Escuro';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get portuguese => 'Português';

  @override
  String get english => 'Inglês';

  @override
  String get publicTransportationTitle => 'Transportes Públicos';

  @override
  String get metrodoporto => 'Metro do Porto';

  @override
  String get stcp => 'STCP';

  @override
  String get stcpFull => 'Sociedade de Transportes Coletivos do Porto';

  @override
  String get cp => 'CP';

  @override
  String get cpFull => 'Comboios de Portugal';

  @override
  String get openSourceLicensesTitle => 'Licenças de Código Aberto';

  @override
  String get license => 'licença';

  @override
  String get supportMessage => 'Feito com ❤️ no Porto';

  @override
  String get debugSettingsTitle => 'Definições de Depuração';

  @override
  String get resetOnboarding => 'Reiniciar Introdução';

  @override
  String get resetOnboardingText1 =>
      'Tem a certeza de que deseja reiniciar o processo de introdução?';

  @override
  String get resetOnboardingText2 => 'Isto irá apagar todos os dados GTFS.';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get search => 'Pesquisar';
}
